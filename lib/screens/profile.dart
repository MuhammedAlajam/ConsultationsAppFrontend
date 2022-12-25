import 'package:consultations/constant.dart';
import 'package:consultations/screens/loading.dart';
import 'package:consultations/services/user_service.dart';
import 'package:flutter/material.dart';

import '../models/expert.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Container(
                width: 100,
                alignment: Alignment.topRight,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            logout();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LoadingScreen()),
                                (route) => false);
                          },
                        );
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('images/login.png'),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Icon(Icons.info, color: Colors.blue[800]),
                      const SizedBox(height: 32),
                      doubleTextView('user name', user?.username ?? ''),
                      const SizedBox(height: 8),
                      doubleTextView('first name', user?.firstName ?? ''),
                      const SizedBox(height: 8),
                      doubleTextView('last name', user?.lastName ?? ''),
                      const SizedBox(height: 8),
                      doubleTextView('country', user?.country ?? ''),
                      const SizedBox(height: 8),
                      doubleTextView('city', user?.city ?? ''),
                      const SizedBox(height: 8),
                      doubleTextView('phone number', user?.phoneNumber ?? ''),
                      const SizedBox(height: 8),
                      if (user?.roleType != 'user')
                        Column(
                          children: [
                            doubleTextView('description',
                                (user as Expert).description ?? ''),
                            const SizedBox(height: 8),
                            doubleTextView('rate', (user as Expert).rate ?? ''),
                            const SizedBox(height: 8),
                            doubleTextView('hourly rate',
                                '${(user as Expert).hourlyRate ?? ''} USD'),
                            const SizedBox(height: 8),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
