import 'dart:convert';
import 'package:consultations/constant.dart';
import 'package:consultations/models/expert.dart';
import 'package:consultations/models/user.dart';
import 'package:consultations/screens/login.dart';
import 'package:consultations/services/expert_service.dart';
import 'package:consultations/services/user_service.dart';
import 'package:flutter/material.dart';
import 'home.dart';

User? user;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

void _sendAvailableHoursForDay(String day) async {
  setAvailableTimes(day, jsonEncode(workHours[day]));
}

void _sendAvailableHours() async {
  for (int i = 0; i < weekDays.length; i++) {
    _sendAvailableHoursForDay(weekDays.elementAt(i));
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  void loadUserInfo() async {
    String userJson = await getUserDataFromMemory();

    if (userJson == '') {
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false);
    } else {
      var json = jsonDecode(userJson) as Map<dynamic, dynamic>;

      if (json['user']['role_type'] == 'user') {
        user = User.fromJson(json);
      } else {
        user = Expert.fromJson(json);
      }

      _sendAvailableHours();
      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const Home()),
          (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserInfo();
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
