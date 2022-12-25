import 'package:flutter/material.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

Widget consultationCard(String name, int id) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 50),
    child: GestureDetector(
      onTap: () => {
        // TODO
        //1: send consultation id, get list of experts, close consultaions.
        //2: view experts list instead of consultaions list
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow.shade600,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Center(
            child: Text(
              name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ),
  );
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  // TODO make it dynamic (get consultations by request)

  List<String> consultationsList = [
    'Medical',
    'Familial',
    'Business',
    'dsfvfsdfffsds',
    'edsfffafdd',
    'xxxxxxxxxxxx',
    'Business',
    'dsfvfsdfffsds',
    'edsfffafdd',
    'Business',
    'dsfvfsdfffsds',
    'edsfffafdd',
    'Business',
    'dsfvfsdfffsds',
    'edsfffafdd',
    'Business',
    'dsfvfsdfffsds',
    'edsfffafdd'
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          for (int i = 0; i < consultationsList.length; i++)
            consultationCard(consultationsList[i], i + 1),
        ],
      ),
    );
  }
}
