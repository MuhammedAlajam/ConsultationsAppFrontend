import 'package:consultations/models/api_response.dart';
import 'package:consultations/services/expert_service.dart';
import 'package:flutter/material.dart';

class ExpertsScreen extends StatefulWidget {
  final String path, data;
  const ExpertsScreen({super.key, required this.path, required this.data});

  @override
  State<ExpertsScreen> createState() => _ExpertsScreenState(path, data);
}

class _ExpertsScreenState extends State<ExpertsScreen> {
  String path, data;
  _ExpertsScreenState(this.path, this.data);
  var info;

  void _getExperts() async {
    ApiResponse apiResponse = await getExperts(path, data);

    if (apiResponse.error == null) {
      info = apiResponse.data;
    }
  }

  @override
  void initState() {
    super.initState();
    _getExperts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: Container(
        margin: const EdgeInsets.only(right: 8, left: 8, bottom: 16),
        child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              Divider(color: Colors.blue[900], thickness: 1),
          itemCount: info.length,
          itemBuilder: (context, i) {
            return ListTile(
              onTap: () {
                //TODO
              },
              tileColor: Colors.white,
              leading: const CircleAvatar(
                  backgroundImage: AssetImage('images/login.png'), radius: 40),
              title: Text(
                ('${info[i]['first_name']!} ${info[i]['last_name']!}'),
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: [
                  Text(info[i]['rate']!),
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 15,
                  )
                ],
              ),
              trailing: Text(info[i]['hourly_rate']!),
            );
          },
        ),
      ),
    );
  }
}