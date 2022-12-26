import 'dart:convert';

import 'package:consultations/models/api_response.dart';
import 'package:consultations/screens/loading.dart';
import 'package:consultations/services/expert_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';
import '../models/expert.dart';

class SignUpExpertScreen extends StatefulWidget {
  const SignUpExpertScreen({super.key});

  @override
  State<SignUpExpertScreen> createState() => _SignUpExpertScreenState();
}

class _SignUpExpertScreenState extends State<SignUpExpertScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  TextEditingController description = TextEditingController();
  TextEditingController hourlyRate = TextEditingController();
  List<TextEditingController> consultations = [];

  List<Widget> consultationsTextBoxes = [];

  bool loading = false;

  void _signUpExpert() async {
    List<String> consultationsList = [];
    for (int i = 0; i < consultations.length; i++) {
      consultationsList.add(consultations[i].text);
    }

    // remaining : description, hourly rate
    ApiResponse response = await registerExpert(
      username.text,
      firstName.text,
      lastName.text,
      country.text,
      city.text,
      phoneNumber.text,
      password.text,
      description.text,
      hourlyRate.text,
      jsonEncode(consultationsList),
    );

    if (response.error == null) {
      _saveAnsGoToHome(Expert.fromJson(response.data as Map<dynamic, dynamic>));
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void _saveAnsGoToHome(Expert expert) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('userInfo', expert.expertDataToString());
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoadingScreen()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              'Signing up !',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                child: Column(
                  children: [
                    Icon(Icons.abc, color: Colors.blue[800]),
                    const SizedBox(height: 32),
                    textBoxEditWithoutPrefixIcon('username', username, false),
                    const SizedBox(height: 8),
                    textBoxEditWithoutPrefixIcon(
                        'first name', firstName, false),
                    const SizedBox(height: 8),
                    textBoxEditWithoutPrefixIcon('last name', lastName, false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                child: Column(
                  children: [
                    Icon(Icons.location_on_rounded, color: Colors.blue[800]),
                    const SizedBox(height: 32),
                    textBoxEditWithoutPrefixIcon('country', country, false),
                    const SizedBox(height: 8),
                    textBoxEditWithoutPrefixIcon('city', city, false),
                  ],
                ),
              ),
            ),
            Image.asset(
              'images/new_account.png',
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                child: Column(
                  children: [
                    Icon(Icons.info, color: Colors.blue[800]),
                    const SizedBox(height: 32),
                    textBoxEditWithoutPrefixIcon(
                        'phone number', phoneNumber, false),
                    const SizedBox(height: 8),
                    textBoxEditWithoutPrefixIcon('password', password, true),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                child: Column(
                  children: [
                    Icon(Icons.attach_money, color: Colors.blue[800]),
                    const SizedBox(height: 32),
                    textBoxEditWithoutPrefixIcon(
                        'description', description, false),
                    const SizedBox(height: 8),
                    textBoxEditWithoutPrefixIcon(
                        'hourly rate', hourlyRate, false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'Add you consultations :',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    for (int i = 0; i < consultationsTextBoxes.length; i++)
                      Column(
                        children: [
                          consultationsTextBoxes[i],
                          const SizedBox(height: 8),
                        ],
                      ),
                    button(
                      '+',
                      () {
                        setState(
                          () {
                            consultations.add(TextEditingController());
                            consultationsTextBoxes.add(
                              textBoxEditWithoutPrefixIcon(
                                'consultation ${consultations.length}',
                                consultations.last,
                                false,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            loading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : buttonInverse('Sign up', () {
                    setState(() {
                      loading = true;
                      _signUpExpert();
                    });
                  }),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
