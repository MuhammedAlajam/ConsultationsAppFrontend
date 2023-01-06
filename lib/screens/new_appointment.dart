import 'package:consultations/constant.dart';
import 'package:consultations/models/api_response.dart';
import 'package:consultations/services/expert_service.dart';
import 'package:flutter/material.dart';

class NewAppointmentScreen extends StatefulWidget {
  final String expertId;
  const NewAppointmentScreen({super.key, required this.expertId});

  @override
  State<NewAppointmentScreen> createState() =>
      // ignore: no_logic_in_create_state
      _NewAppointmentScreenState(expertId);
}

class _NewAppointmentScreenState extends State<NewAppointmentScreen> {
  String expertId;
  _NewAppointmentScreenState(this.expertId);
  DateTime date = DateTime.now();

  List<String> availabeTimes = [];
  bool choosedDate = false;

  void _getAvailableTimes() async {
    ApiResponse response = await getAvailabeTimes(date.toString(), expertId);
    if (response.error == null) {
      setState(() {
        availabeTimes = response.data as List<String>;
      });
    }
  }

  void _bookTime(String hour) async {
    ApiResponse response = await bookTime(date.toString(), expertId, hour);
    if (response.error == null) {
      setState(() {
        String newWallet =
            (response.data as Map<String, String>)['wallet'].toString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.blue[900],
          content: Text(
              'Booking done successfully, your balance now is : $newWallet'),
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[500],
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(
                right: 20, left: 20, top: 100, bottom: 40),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Text(
              'Book an Appointment !',
              style: TextStyle(
                color: Colors.blue[600],
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
          ),
          buttonInverse(
            'Choose the day',
            () async {
              final nwDate = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime.now().year + 100));

              if (nwDate != null) {
                setState(() {
                  date = nwDate;
                  choosedDate = true;
                  _getAvailableTimes();
                });
              }
            },
          ),
          const SizedBox(height: 15),
          if (choosedDate)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 22),
              margin: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.blue[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    '${date.day} / ${date.month} / ${date.year}',
                    style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          for (int i = 0; i < availabeTimes.length; i++)
                            GestureDetector(
                              onDoubleTap: (() => _bookTime(
                                  availabeTimes.elementAt(i).toString())),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  availabeTimes.elementAt(i).toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
