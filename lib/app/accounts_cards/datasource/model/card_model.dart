import 'package:cloud_firestore/cloud_firestore.dart';

class CardModel {
  double? limit;
  double? availableLimit;
  String? cardName;
  String? flag;
  DateTime? close;
  dynamic id;

  CardModel({
    this.limit,
    this.availableLimit,
    this.cardName,
    this.flag,
    this.close,
    this.id,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    final closeTimestamp = json['close'] as Timestamp?;
    final close = closeTimestamp?.toDate();

    return CardModel(
      limit: (json['limit'] as num?)?.toDouble(),
      availableLimit: (json['availableLimit'] as num?)?.toDouble(),
      cardName: json['cardName'] as String?,
      flag: json['flag'] as String?,
      close: close,
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['availableLimit'] = availableLimit;
    data['cardName'] = cardName;
    data['flag'] = flag;
    data['close'] = close;
    data['id'] = id;
    return data;
  }
}
