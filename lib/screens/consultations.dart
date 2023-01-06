import 'package:consultations/models/api_response.dart';
import 'package:consultations/screens/experts.dart';
import 'package:consultations/screens/home.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../services/consultation_service.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  List<dynamic> consultationsList = [];
  bool loading = false;
  late List<DropdownMenuItem<String>> consultationsListDropDown;

  void _getConsultationsList() async {
    ApiResponse response = await getConsultations();

    if (response.error == null) {
      loading = false;
      setState(() {
        consultationsList = response.data as List<dynamic>;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    _getConsultationsList();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: loading
          ? const CircularProgressIndicator(color: Colors.blue)
          : ListView(
              children: [
                for (int i = 0; i < consultationsList.length; i++)
                  consultationCard(
                    consultationsList.elementAt(i).toString(),
                    i + 1,
                    () {
                      if (searchString == '') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExpertsScreen(
                                    path: consultaionExpertsUrl,
                                    data: (i + 1).toString())));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExpertsScreen(
                                    path:
                                        '$filteredSearch${i + 1}/$searchString',
                                    data: '')));
                      }
                    },
                  ),
              ],
            ),
    );
  }
}
