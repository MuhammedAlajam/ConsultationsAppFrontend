import 'package:consultations/constant.dart';
import 'package:consultations/models/api_response.dart';
import 'package:consultations/screens/expert_profile.dart';
import 'package:consultations/services/user_service.dart';
import 'package:flutter/material.dart';

class BookedTimesUserScreen extends StatefulWidget {
  const BookedTimesUserScreen({super.key});

  @override
  State<BookedTimesUserScreen> createState() => _BookedTimesUserScreenState();
}

class _BookedTimesUserScreenState extends State<BookedTimesUserScreen> {
  List<dynamic> bookedTimes = [];
  bool loading = false;

  void _getTimes() async {
    ApiResponse response = await getUserBookedTimes();

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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: loading
          ? const CircularProgressIndicator(color: Colors.blue)
          : ListView(
              children: [
                for (int i = 0; i < bookedTimes.length; i++)
                  userTimeCard(
                      bookedTimes.elementAt(i)['date'],
                      bookedTimes.elementAt(i)['hour'],
                      '${bookedTimes.elementAt(i)['expert_first_name']} ${bookedTimes.elementAt(i)['expert_last_name']}',
                      () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExpertProfileScreen(
                                  idExpert: bookedTimes
                                      .elementAt(i)['expert_id']
                                      .toString(),
                                )));
                  })
              ],
            ),
    );
  }
}
