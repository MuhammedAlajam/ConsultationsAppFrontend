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
  // TODO full new appointment screen
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
