import 'dart:convert';
import 'dart:math';
import 'package:cons_frontend/models/expert.dart';
import 'package:cons_frontend/models/user.dart';
import 'package:cons_frontend/screens/login.dart';
import 'package:cons_frontend/services/user_service.dart';
import 'package:flutter/material.dart';
import 'home.dart';

User? user;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void loadUserInfo() async {
    String userJson = await getUserDataFromMemory();

    if (userJson == '') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    } else {
      var json = jsonDecode(userJson) as Map<dynamic, dynamic>;
      if (json['role_type'] == 'user') {
        user = User.fromJson(json);
      } else {
        user = Expert.fromJson(json);
      }
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Home()),
          (route) => false);
      /*
      ApiResponse response = await getDataUser();
      if (response.error == null) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const Home()),
            (route) => false);
      } else if (response.error == unauthorized) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${response.error}',
            ),
          ),
        );
      }
      */
    }
  }

  @override
  void initState() {
    loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: CircularProgressIndicator(color: Colors.blue[800]),
      ),
    );
  }
}
