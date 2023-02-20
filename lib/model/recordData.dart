class RecordModel {
  final int id;
  final String title;
  final int expense;
  final int profit;
  final String description;
  final String plans;
  final String userName;
  final String addedDate;

  RecordModel({
    required this.id,
    required this.title,
    required this.expense,
    required this.profit,
    required this.description,
    required this.plans,
    required this.userName,
    required this.addedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'expense': expense,
      "profit": profit,
      "description": description,
      "plans": plans,
      "username": userName,
      "addeddate": addedDate,
    };
  }

  factory RecordModel.fromJson(Map<String, dynamic> map) {
    return RecordModel(
      id: map['id'],
      title: map['title'],
      expense: map['expense'],
      profit: map['profit'],
      description: map['description'],
      plans: map['plans'],
      userName: map['username'],
      addedDate: map['addeddate'],
    );
  }
}
