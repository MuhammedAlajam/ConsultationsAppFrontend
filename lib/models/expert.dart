import 'dart:convert';
import 'package:consultations/models/user.dart';

class Expert extends User {
  String? description;
  String? hourlyRate;

  Expert({
    this.description,
    this.hourlyRate,
  }) : super();

  Expert.fromJson(Map<dynamic, dynamic> json) {
    username = json['user']['username'];
    firstName = json['user']['first_name'];
    lastName = json['user']['last_name'];
    country = json['user']['country'];
    city = json['user']['city'];
    phoneNumber = json['user']['phone_number'];
    wallet = json['user']['wallet'];
    roleType = json['user']['role_type'];
    token = json['token'];
    description = json['user']['description'];
    hourlyRate = json['user']['hourly_rate'];
  }

  String expertDataToString() {
    String ret = jsonEncode({
      'user': {
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'country': country,
        'city': city,
        'phone_number': phoneNumber,
        'wallet': wallet,
        'role_type': roleType,
        'description': description,
        'hourly_rate': hourlyRate,
      },
      'token': token,
    });

    return ret;
  }
}
