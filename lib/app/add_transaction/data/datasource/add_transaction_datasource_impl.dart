import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'add_transaction_datasource.dart';

class AddTransactionDataImpl implements AddTransactionData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addTransaction(
      String uid, Map<String, dynamic> transactionData, bool add) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('transaction')
        .add(transactionData);
  }

  @override
  Future<List<dynamic>> getCategories() async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('app').doc('tWjoyheOrfkAKYHylzH1').get();

      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null &&
          data.containsKey('categories') &&
          data['categories'] is List) {
        return List<dynamic>.from(data['categories']);
      } else {
        if (kDebugMode) {
          print("Campo 'categories' não encontrado ou não é uma lista.");
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao buscar categorias: $e");
      }
      return [];
    }
  }

  @override
  Future<List<dynamic>> getPayments() async {
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection('app').doc('tWjoyheOrfkAKYHylzH1').get();

      Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
      if (data != null &&
          data.containsKey('payment') &&
          data['payment'] is List) {
        return List<dynamic>.from(data['payment']);
      } else {
        if (kDebugMode) {
          print("Campo 'payment' não encontrado ou não é uma lista.");
        }
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao buscar pagamentos: $e");
      }
      return [];
    }
  }
}
