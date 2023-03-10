import 'package:consultations/models/api_response.dart';
import 'package:consultations/models/expert.dart';
import 'package:consultations/models/user.dart';
import 'package:consultations/screens/loading.dart';
import 'package:consultations/screens/signup_expert.dart';
import 'package:consultations/screens/signup_user.dart';
import 'package:consultations/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant.dart';

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
      SharedPreferences pref = await SharedPreferences.getInstance();

      if (User.fromJson(response.data as Map<dynamic, dynamic>).roleType ==
          'user') {
        pref.setString(
            'userInfo',
            User.fromJson(response.data as Map<dynamic, dynamic>)
                .userDataToString());
      } else {
        pref.setString(
            'userInfo',
            Expert.fromJson(response.data as Map<dynamic, dynamic>)
                .expertDataToString());
      }

      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoadingScreen()),
          (route) => false);
    } else {
      setState(() {
        loading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue[900],
          content: Text('${response.error}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.asset(
              'images/login.png',
              height: 300,
            ),
            const SizedBox(height: 24),
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
                    textBoxEdit('username', username, false, Icons.email),
                    const SizedBox(height: 8),
                    textBoxEdit('password', password, true, Icons.password),
                    const SizedBox(height: 8),
                    loading
                        ? Center(
                            child: CircularProgressIndicator(
                                color: Colors.blue[800]),
                          )
                        : button('Sign in', () {
                            setState(() {
                              loading = true;
                              _loginUser();
                            });
                          }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textButton('sign up as user', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpUserScreen()));
                    }),
                    Text('|', style: TextStyle(color: Colors.blue[600])),
                    textButton('sign up as expert', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SignUpExpertScreen()));
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
