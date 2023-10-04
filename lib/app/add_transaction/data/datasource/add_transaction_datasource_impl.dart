import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'add_transaction_datasource.dart';

class AddTransactionDataImpl implements AddTransactionData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addTransaction(
      String uid, Map<String, dynamic> transactionData, bool add) async {
    DateTime now = DateTime.now();
    String monthYear = DateFormat('MMM yyyy').format(now);

    await _firestore
        .collection('house')
        .doc(uid)
        .collection(monthYear)
        .add(transactionData);

    await _firestore.collection('house').doc(uid).set({
      'subcollections': FieldValue.arrayUnion([monthYear])
    }, SetOptions(merge: true));

    if (!add) {
      await updateCategoryExpense(
          uid, transactionData['categoria'], transactionData['valor']);
    }
  }

  @override
  Future<void> updateCategoryExpense(
      String uid, String category, double value) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('house').doc(uid).get();
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    double currentExpense =
        (userData['categoryExpenses'] ?? {})[category] ?? 0.0;
    currentExpense += value;

    await _firestore.collection('house').doc(uid).update({
      'categoryExpenses.$category': currentExpense,
    });
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

  @override
  Future<List<String>> getAccountBanks(String houseId) async {
    try {
      final houseDoc = await _firestore.collection('house').doc(houseId).get();
      if (!houseDoc.exists) {
        return [];
      }

      final accountBanksCollection =
          houseDoc.reference.collection('accountBanks');
      final querySnapshot = await accountBanksCollection.get();

      List<String> banks =
          querySnapshot.docs.map((doc) => doc['bank'] as String).toList();

      return banks;
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao buscar os bancos: $e");
      }
      return [];
    }
  }

  @override
  Future<void> updateBalance(String houseId, double valor, bool add) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('house').doc(houseId).get();
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

    await _firestore.collection('house').doc(houseId).update({
      'balance': currentBalance,
    });

    String currentMonth = DateTime.now().toString().substring(0, 7);

    if (add == true) {
      double currentGain = (userData['ganhos'] ?? {})[currentMonth] ?? 0.0;
      currentGain += valor;
      await _firestore.collection('house').doc(houseId).update({
        'ganhos.$currentMonth': currentGain,
      });
    } else if (add == false) {
      double currentExpense = (userData['gastos'] ?? {})[currentMonth] ?? 0.0;
      currentExpense += valor;
      await _firestore.collection('house').doc(houseId).update({
        'gastos.$currentMonth': currentExpense,
      });
    }
  }

  @override
  Future<void> updateAccountBalance(
      String houseId, String bank, double valor, bool add) async {
    try {
      final houseDoc = _firestore.collection('house').doc(houseId);
      final houseSnapshot = await houseDoc.get();

      if (!houseSnapshot.exists) {
        if (kDebugMode) {
          print('Casa não encontrada.');
        }
        return;
      }

      final accountBanksCollection = houseDoc.collection('accountBanks');
      final querySnapshot =
          await accountBanksCollection.where('bank', isEqualTo: bank).get();

      final accountDoc = querySnapshot.docs.first;
      final currentBalance = (accountDoc['balance'] as num?)?.toDouble() ?? 0.0;

      double newBalance = add ? currentBalance + valor : currentBalance - valor;
      await accountDoc.reference.update({'balance': newBalance});
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao atualizar o saldo da conta bancária: $e");
      }
    }
  }
}
