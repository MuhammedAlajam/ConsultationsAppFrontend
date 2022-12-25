import 'package:cons_frontend/models/apiResponse.dart';
import 'package:cons_frontend/models/user.dart';
import 'package:cons_frontend/screens/loading.dart';
import 'package:cons_frontend/screens/signUpExpert.dart';
import 'package:cons_frontend/screens/signUpUser.dart';
import 'package:cons_frontend/services/user_service.dart';
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
      debugPrint('I reached here !!!');
      _saveAnsGoToHome(User.fromJson(response.data as Map<String, dynamic>));
    } else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue[900],
          content: Text('${response.error}')));
    }
  }

  void _saveAnsGoToHome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('userInfo', user.userDataToString());
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
