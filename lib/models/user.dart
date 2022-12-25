import 'dart:convert';

class User {
  String? username;
  String? firstName;
  String? lastName;
  String? country;
  String? city;
  String? token;
  String? profilePhoto;
  String? phoneNumber;
  String? roleType;
  int? wallet;

  User({
    this.username,
    this.firstName,
    this.lastName,
    this.profilePhoto,
    this.country,
    this.city,
    this.wallet,
    this.token,
    this.phoneNumber,
    this.roleType,
  });

  User.fromJson(Map<dynamic, dynamic> json) {
    username = json['user']['name'];
    firstName = json['user']['first_name'];
    lastName = json['user']['last_name'];
    profilePhoto = json['user']['profile_photo'];
    country = json['user']['country'];
    city = json['user']['city'];
    phoneNumber = json['user']['phone_number'];
    roleType = json['user']['role_type'];
    token = json['token'];
  }

  String userDataToString() {
    return jsonEncode({
      'user': {
        'name': username,
        'first_name': firstName,
        'last_name': lastName,
        'profile_photo': profilePhoto,
        'country': country,
        'city': city,
        'phone_number': phoneNumber,
        'role_type': roleType,
      },
      'token': token,
    });
  }
}
