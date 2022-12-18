import 'package:cons_frontend/models/api_response.dart';
import 'package:cons_frontend/screens/home.dart';
import 'package:cons_frontend/screens/signUpExpert.dart';
import 'package:cons_frontend/screens/signUpUser.dart';
import 'package:cons_frontend/services/expert_service.dart';
import 'package:cons_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

Widget buildUserName(TextEditingController textEditingController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        ' User name',
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
        height: 60,
        child: TextField(
          controller: textEditingController,
          style: const TextStyle(color: Colors.black87),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(Icons.email, color: Colors.teal),
          ),
        ),
      )
    ],
  );
}

Widget buildPassword(TextEditingController textEditingController) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        ' Password',
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
        height: 60,
        child: TextField(
          controller: textEditingController,
          obscureText: true,
          style: const TextStyle(color: Colors.black87),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(Icons.lock, color: Colors.teal),
          ),
        ),
      )
    ],
  );
}

Widget buildSignUpButtons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpUserScreen()),
          );
        },
        child: Text(
          'sign up as user',
          style: TextStyle(
              color: Colors.teal.shade100, fontWeight: FontWeight.bold),
        ),
      ),
      const SizedBox(width: 10),
      Text(
        '|',
        style:
            TextStyle(color: Colors.teal.shade100, fontWeight: FontWeight.bold),
      ),
      const SizedBox(width: 10),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpExpertScreen()),
          );
        },
        child: Text(
          'sign up as Expert',
          style: TextStyle(
              color: Colors.teal.shade100, fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loading = false;

  void _loginUser() async {
    ApiResponse response = await loginUser(username.text, password.text);

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
                        'Sign in',
                        style: TextStyle(
                            color: Colors.teal.shade700,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 120),
                      buildUserName(username),
                      const SizedBox(height: 20),
                      buildPassword(password),
                      const SizedBox(height: 10),
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
                                    _loginUser();
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
                      const SizedBox(height: 30),
                      buildSignUpButtons(context),
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
