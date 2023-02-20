class UnverifiedMarket {
  final int id;
  final String title;
  final int price;
  final String quantity;
  final String description;
  final String username;
  final String location;
  final String phone;
  final String type;
  bool verified;
  final String imageUrl;

  void isVerified(bool verified) {
    this.verified = verified;
  }

  UnverifiedMarket({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.description,
    required this.username,
    required this.location,
    required this.type,
    required this.phone,
    required this.imageUrl,
    required this.verified,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      "quantity": quantity,
      "description": description,
      "imagefile": imageUrl,
      "username": username,
      "location": location,
      "productType": type,
      "phone": phone,
      "verified": verified,
    };
  }

  factory UnverifiedMarket.fromJson(Map<String, dynamic> map) {
    return UnverifiedMarket(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      quantity: map['quantity'],
      description: map['description'],
      imageUrl: map['imagefile'],
      username: map['username'],
      phone: map['phone'],
      location: map['location'],
      type: map['type'],
      verified: map['verified'],
    );
  }
}
