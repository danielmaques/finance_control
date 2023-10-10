import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsModel {
  bool add;
  String categoria;
  DateTime? time;
  String descricao;
  String pagamento;
  double valor;

  TransactionsModel({
    required this.add,
    required this.categoria,
    this.time,
    required this.descricao,
    required this.pagamento,
    required this.valor,
  });

  factory TransactionsModel.fromJson(Map<String, dynamic> json) {
    final timestamp = json['time'] as Timestamp?;
    final time = timestamp?.toDate();

    return TransactionsModel(
      add: json['add'] as bool? ?? false,
      categoria: json['categoria'] as String? ?? '',
      time: time,
      descricao: json['descricao'] as String? ?? '',
      pagamento: json['pagamento'] as String? ?? '',
      valor: (json['valor'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['add'] = add;
    data['categoria'] = categoria;
    data['time'] = time;
    data['descricao'] = descricao;
    data['pagamento'] = pagamento;
    data['valor'] = valor;
    return data;
  }
}
