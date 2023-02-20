class ProductsModel {
  final int id;
  final String title;
  final int price;
  final String quantity;
  final String description;
  final String type;
  final String username;
  final String location;
  final String phone;
  final String addedDate;
  bool market;
  bool premium;
  final String imageUrl;

  void isMarket(bool market) {
    this.market = market;
  }

  void isPremium(bool premium) {
    this.premium = premium;
  }

  ProductsModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity,
      required this.description,
      required this.username,
      required this.location,
      required this.type,
      required this.premium,
      required this.phone,
      required this.addedDate,
      required this.imageUrl,
      required this.market});

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
      "phone": phone,
      "addedDate": addedDate,
      "market": market,
      "type": type,
    };
  }

  factory ProductsModel.fromJson(Map<String, dynamic> map) {
    return ProductsModel(
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
