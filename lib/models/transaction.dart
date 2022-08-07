class TransactionModel {
  final String? id;
  final String? type;
  final String? image;
  final String? name;
  final String? amount;
  final String? date;
  final String? time;
  final String? category;
  final String? mode;

  TransactionModel({
    this.id,
    this.type,
    this.image,
    this.name,
    this.amount,
    this.date,
    this.time,
    this.category,
    this.mode,
  });

  TransactionModel fromJson(Map<String, dynamic> json) => TransactionModel(
        id: json['id'],
        type: json['type'],
        image: json['image'],
        amount: json['amount'],
        name: json['name'],
        date: json['date'],
        time: json['time'],
        category: json['category'],
        mode: json['mode'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'image': image,
        'name': name,
        'amount': amount,
        'date': date,
        'time': time,
        'category': category,
        'mode': mode,
      };
}
