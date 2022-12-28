import 'package:flutter/material.dart';

class NewAppointmentScreen extends StatefulWidget {
  final String expertId;
  const NewAppointmentScreen({super.key, required this.expertId});

  @override
  State<NewAppointmentScreen> createState() =>
      _NewAppointmentScreenState(expertId);
}

class _NewAppointmentScreenState extends State<NewAppointmentScreen> {
  String expertId;
  _NewAppointmentScreenState(this.expertId);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
