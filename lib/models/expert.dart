import 'dart:convert';

import 'package:cons_frontend/models/user.dart';

class Expert extends User {
  String? description;
  String? hourlyRate;
  String? rate;

  Expert({
    this.description,
    this.hourlyRate,
  }) : super();

  Expert.fromJson(Map<String, dynamic> json) {
    User.fromJson(json);
    description = json['expert_info']['description'];
    hourlyRate = json['expert_info']['hourly_rate'];
    rate = json['expert_info']['rate'];
  }
  @override
  String userDataToString() {
    var data = json.decode(super.userDataToString());
    Map<String, dynamic> extra = {
      'expert_info': {
        'description': description,
        'hourly_rate': hourlyRate,
        'rate': rate
      }
    };
    data.addAll(extra);

    return jsonEncode(data);
  }
}
