import 'package:consultations/constant.dart';
import 'package:consultations/models/api_response.dart';
import 'package:consultations/services/expert_service.dart';
import 'package:flutter/material.dart';

class ExpertBookedTimes extends StatefulWidget {
  const ExpertBookedTimes({super.key});

  @override
  State<ExpertBookedTimes> createState() => _ExpertBookedTimesState();
}

class _ExpertBookedTimesState extends State<ExpertBookedTimes> {
  List<dynamic> bookedTimes = [];
  bool loading = false;

  void _getTimes() async {
    ApiResponse response = await getExpertBookedTimes();

    if (response.error == null) {
      loading = false;
      setState(() {
        bookedTimes = response.data as List<dynamic>;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    _getTimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 50),
        child: loading
            ? const CircularProgressIndicator(color: Colors.blue)
            : ListView(
                children: [
                  for (int i = 0; i < bookedTimes.length; i++)
                    userTimeCard(
                      bookedTimes.elementAt(i)['date'],
                      bookedTimes.elementAt(i)['hour'],
                      '${bookedTimes.elementAt(i)['user_first_name']} ${bookedTimes.elementAt(i)['user_last_name']}',
                      () {},
                    )
                ],
              ),
      ),
    );
  }
}
