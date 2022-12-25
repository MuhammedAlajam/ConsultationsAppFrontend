import 'package:consultations/models/api_response.dart';
import 'package:consultations/models/user.dart';
import 'package:consultations/screens/loading.dart';
import 'package:consultations/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant.dart';

class SignUpUserScreen extends StatefulWidget {
  const SignUpUserScreen({super.key});

  @override
  State<SignUpUserScreen> createState() => _SignUpUserScreenState();
}

class _SignUpUserScreenState extends State<SignUpUserScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  bool loading = false;

  void _signUpUser() async {
    ApiResponse response = await registerUser(
        username.text,
        firstName.text,
        lastName.text,
        country.text,
        city.text,
        "path",
        phoneNumber.text,
        password.text);

    if (response.error == null) {
      _saveAnsGoToHome(User.fromJson(response.data as Map<String, dynamic>));
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  void _saveAnsGoToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('userInfo', user.userDataToString());

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
            const SizedBox(height: 8),
            loading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : buttonInverse('Sign up', () {
                    setState(() {
                      loading = true;
                      _signUpUser();
                    });
                  }),
          ],
        ),
      ),
    );
  }
}
