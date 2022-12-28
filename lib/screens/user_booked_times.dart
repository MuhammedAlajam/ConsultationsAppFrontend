import 'package:consultations/constant.dart';
import 'package:flutter/material.dart';

class BookedTimesUserScreen extends StatefulWidget {
  const BookedTimesUserScreen({super.key});

  @override
  State<BookedTimesUserScreen> createState() => _BookedTimesUserScreenState();
}

class _BookedTimesUserScreenState extends State<BookedTimesUserScreen> {
  List<dynamic> bookedTimes = [];
  bool loading = true;

  void _getTimes() async {
    loading = false;
    bookedTimes = [
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
      {
        'date': '27/12/2022',
        'hour': '08:00',
        'expert_first_name': 'Ibrahim',
        'expert_last_name': 'hammash',
        'expert_id': '1',
      },
    ];
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
                    // TODO go to expert page
                  })
              ],
            ),
    );
  }
}
