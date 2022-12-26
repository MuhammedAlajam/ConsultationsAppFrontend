import 'dart:convert';

class User {
  String? username;
  String? firstName;
  String? lastName;
  String? country;
  String? city;
  String? phoneNumber;
  String? wallet;
  String? token;
  String? roleType;

  User({
    this.username,
    this.firstName,
    this.lastName,
    this.country,
    this.city,
    this.phoneNumber,
    this.wallet,
    this.token,
    this.roleType,
  });

  User.fromJson(Map<dynamic, dynamic> json) {
    username = json['user']['username'];
    firstName = json['user']['first_name'];
    lastName = json['user']['last_name'];
    country = json['user']['country'];
    city = json['user']['city'];
    phoneNumber = json['user']['phone_number'];
    wallet = json['user']['wallet'];
    roleType = json['user']['role_type'];
    token = json['token'];
  }

  String userDataToString() {
    return jsonEncode({
      'user': {
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'country': country,
        'city': city,
        'phone_number': phoneNumber,
        'wallet': wallet,
        'role_type': roleType,
      },
      'token': token,
    });
  }
}
