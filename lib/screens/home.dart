import 'package:cons_frontend/screens/mainExpertsScreen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade700,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.teal.shade100,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.star,
              color: Colors.teal.shade100,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person,
              color: Colors.teal.shade100,
            ),
          ),
        ],
      ),
      body: const mainExpertsScreen(),
    );
  }
}
