import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsModel {
  bool add;
  String category;
  DateTime? time;
  String method;
  String description;
  double value;

  TransactionsModel({
    required this.add,
    required this.category,
    this.time,
    required this.method,
    required this.description,
    required this.value,
  });

  factory TransactionsModel.fromJson(Map<String, dynamic> json) {
    final timestamp = json['time'] as Timestamp?;
    final time = timestamp?.toDate();

    return TransactionsModel(
      add: json['add'] as bool? ?? false,
      category: json['category'] as String? ?? '',
      time: time,
      method: json['method'] as String? ?? '',
      description: json['description'] as String? ?? '',
      value: (json['value'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['add'] = add;
    data['category'] = category;
    data['time'] = time;
    data['method'] = method;
    data['description'] = description;
    data['value'] = value;
    return data;
  }
}
