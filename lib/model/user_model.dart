class User {
  final String username;
  final String email;
  final String phone;
  final String country;
  final String town;
  final bool premium;
  final bool market;
  final bool upload;

  User(
      {required this.username,
      required this.email,
      required this.phone,
      required this.country,
      required this.town,
      required this.premium,
      required this.market,
      required this.upload});

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone': phone,
      'country': country,
      'town': town,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      email: map['email'],
      phone: map['phone'],
      country: map['country'],
      town: map['town'],
      premium: map['premium'],
      market: map['market'],
      upload: map['upload'],
    );
  }
}
