class MarketModel {
  final int id;
  final String title;
  final int price;
  final String quantity;
  final String description;
  final String username;
  final String location;
  final String phone;
  final String type;
  final String addedDate;
  final bool market;
  final bool premium;
  final String imageUrl;

  MarketModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.description,
    required this.username,
    required this.location,
    required this.type,
    required this.phone,
    required this.addedDate,
    required this.imageUrl,
    required this.market,
    required this.premium,
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
      "addedDate": addedDate,
      "market": market,
      "premium": premium,
    };
  }

  factory MarketModel.fromJson(Map<String, dynamic> map) {
    return MarketModel(
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
      addedDate: map['addedDate'],
      market: map['market'],
      premium: map['premium'],
    );
  }
}
