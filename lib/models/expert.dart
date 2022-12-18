class Expert {
  int? id;
  String? username;
  String? first_name;
  String? last_name;
  String? country;
  String? city;
  String? token;
  String? profile_photo;
  String? phone_number;
  int? wallet;

  // and so on
  Expert(
      {this.id,
      this.username,
      this.first_name,
      this.last_name,
      this.profile_photo,
      this.country,
      this.city,
      this.wallet,
      this.token});

  factory Expert.fromJson(Map<String, dynamic> json) {
    return Expert(
      id: json['user']['id'],
      username: json['user']['username'],
      first_name: json['user']['first_name'],
      last_name: json['user']['last_name'],
      profile_photo: json['user']['profile_photo'],
      country: json['user']['country'],
      city: json['user']['city'],
      wallet: json['user']['wallet'],
      token: json['token'],
    );
  }
}
