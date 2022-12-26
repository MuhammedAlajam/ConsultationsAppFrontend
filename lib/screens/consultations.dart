import 'package:consultations/models/api_response.dart';
import 'package:consultations/screens/experts.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../services/consultation_service.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  List<String> consultationsList = [];
  bool foundData = false;

  void _getConsultationsList() async {
    ApiResponse response = await getConsultations();

    if (response.error == null) {
      foundData = true;
      consultationsList = response.data as List<String>;
    }
  }

  @override
  void initState() {
    super.initState();
    _getConsultationsList();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: !foundData
          ? const Text("Sorry, No data found !")
          : ListView(
              children: [
                for (int i = 0; i < consultationsList.length; i++)
                  consultationCard(
                    consultationsList[i],
                    i + 1,
                    () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExpertsScreen(
                                  path: consultaionExpertsUrl,
                                  data: (i + 1).toString())));
                    },
                  ),
              ],
            ),
    );
  }
}
