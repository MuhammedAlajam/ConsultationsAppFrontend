import 'package:cons_frontend/models/api_response.dart';
import 'package:cons_frontend/screens/loadingScreen.dart';
import 'package:cons_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'home.dart';

class SignUpUserScreen extends StatefulWidget {
  const SignUpUserScreen({super.key});

  @override
  State<SignUpUserScreen> createState() => _SignUpUserScreenState();
}

Widget buildTextWithTextField(
    String text, bool obs, TextEditingController textEditingController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        text,
        style: TextStyle(
          color: Colors.teal.shade900,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black,
                blurRadius: 6,
                offset: Offset(0, 2),
              )
            ]),
        height: 40,
        child: TextField(
          controller: textEditingController,
          obscureText: obs,
          style: const TextStyle(color: Colors.black87),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
          ),
        ),
      )
    ],
  );
}

class _SignUpUserScreenState extends State<SignUpUserScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  bool loading = false;

  void _signupUser() async {
    ApiResponse response = await registerUser(
        username.text,
        first_name.text,
        last_name.text,
        country.text,
        city.text,
        "path ",
        phone_number.text,
        password.text);

    if (response.error == null) {
      _saveAnsGoToHome(response.data as User);
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.teal.shade900,
          content: Text(
            '${response.error}',
          ),
        ),
      );
    }
  }

  void _saveAnsGoToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('id', user.id ?? 0);

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.teal,
                    ],
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 100,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Signing Up !',
                        style: TextStyle(
                            color: Colors.teal.shade700,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 60),
                      buildTextWithTextField('user name', false, username),
                      const SizedBox(height: 10),
                      buildTextWithTextField('first name', false, first_name),
                      const SizedBox(height: 10),
                      buildTextWithTextField('last name', false, last_name),
                      const SizedBox(height: 10),
                      buildTextWithTextField('country', false, country),
                      const SizedBox(height: 10),
                      buildTextWithTextField('city', false, city),
                      const SizedBox(height: 10),
                      buildTextWithTextField(
                          'phone number', false, phone_number),
                      const SizedBox(height: 10),
                      buildTextWithTextField('password', true, password),
                      const SizedBox(height: 30),
                      loading
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: Colors.teal.shade300),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal.shade100),
                                onPressed: () => setState(
                                  () {
                                    loading = true;
                                    _signupUser();
                                  },
                                ),
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.teal.shade900,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
