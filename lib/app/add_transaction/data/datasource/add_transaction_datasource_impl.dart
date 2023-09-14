import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'add_transaction_datasource.dart';

class AddTransactionDataImpl implements AddTransactionData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addTransaction(
      String uid, Map<String, dynamic> transactionData, bool add) async {
    // Determinar o mês e o ano atual
    DateTime now = DateTime.now();
    String monthYear = DateFormat('MMM yyyy').format(now);

    await _firestore
        .collection('users')
        .doc(uid)
        .collection(monthYear)
        .add(transactionData);

    await _firestore.collection('users').doc(uid).set({
      'subcollections': FieldValue.arrayUnion([monthYear])
    }, SetOptions(merge: true));
  }

  @override
  Future<void> updateBalance(String uid, double valor, bool add) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();
    double currentBalance = 0.0;

    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    if (userDoc.exists && userData['balance'] != null) {
      currentBalance = userData['balance'].toDouble();
    }

    if (add == true) {
      currentBalance += valor;
    } else if (add == false) {
      currentBalance -= valor;
    }

    // Atualiza o saldo
    await _firestore.collection('users').doc(uid).update({
      'balance': currentBalance,
    });

    // Atualiza gastos e ganhos
    String currentMonth =
        DateTime.now().toString().substring(0, 7); // "YYYY-MM"

    if (add == true) {
      double currentGain = (userData['ganhos'] ?? {})[currentMonth] ?? 0.0;
      currentGain += valor;
      await _firestore.collection('users').doc(uid).update({
        'ganhos.$currentMonth': currentGain,
      });
    } else if (add == false) {
      double currentExpense = (userData['gastos'] ?? {})[currentMonth] ?? 0.0;
      currentExpense += valor;
      await _firestore.collection('users').doc(uid).update({
        'gastos.$currentMonth': currentExpense,
      });
    }
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
