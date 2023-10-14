import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  bool? add;
  String? category;
  String? description;
  DateTime? time;
  String? method;
  double? value;
  String? creditCard;

  TransactionModel({
    this.add,
    this.category,
    this.description,
    this.time,
    this.method,
    this.value,
    this.creditCard,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    final timestamp = json['time'] as Timestamp?;
    final time = timestamp?.toDate();

    return TransactionModel(
      add: json['add'] as bool? ?? false,
      category: json['category'] as String? ?? '',
      description: json['description'] as String? ?? '',
      time: time,
      method: json['method'] as String? ?? '',
      value: json['value'] as double? ?? 0.0,
      creditCard: json['creditCard'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['add'] = add;
    data['category'] = category;
    data['description'] = description;
    data['time'] = time;
    data['method'] = method;
    data['value'] = value;
    data['creditCard'] = creditCard;
    return data;
  }
}
