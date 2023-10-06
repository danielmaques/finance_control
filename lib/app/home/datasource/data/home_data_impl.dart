import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'home_data.dart';

class HomeDataImpl implements HomeData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<void> updateBalance(String uid, double valor, bool add) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('house').doc(uid).get();
    double currentBalance = 0.0;

    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    if (userDoc.exists && userData['balance'] != null) {
      currentBalance = userData['balance'].toDouble();
    }

    if (add) {
      currentBalance += valor;
    } else {
      currentBalance -= valor;
    }

    await _firestore.collection('house').doc(uid).update({
      'balance': currentBalance,
    });

    String currentMonth = DateTime.now().toString().substring(0, 7);

    if (add) {
      double currentGain = (userData['ganhos'] ?? {})[currentMonth] ?? 0.0;
      currentGain += valor;
      await _firestore.collection('house').doc(uid).update({
        'ganhos.$currentMonth': currentGain,
      });
    } else {
      double currentExpense = (userData['gastos'] ?? {})[currentMonth] ?? 0.0;
      currentExpense += valor;
      await _firestore.collection('house').doc(uid).update({
        'gastos.$currentMonth': currentExpense,
      });
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getTransaction(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('house').doc(uid).get();
    List<String> subcollections =
        List<String>.from(userDoc['subcollections'] ?? []);

    List<Map<String, dynamic>> allTransactions = [];

    for (var subcollection in subcollections) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('house')
          .doc(uid)
          .collection(subcollection)
          .get();

      allTransactions.addAll(
        querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList(),
      );
    }

    return allTransactions;
  }

  @override
  Future<String> upload(File imageFile, String uid) async {
    Reference ref = _firebaseStorage
        .ref()
        .child('comprovantes')
        .child(uid)
        .child(DateTime.now().toIso8601String());
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    return await taskSnapshot.ref.getDownloadURL();
  }

  @override
  Future<double> getBalance(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('house').doc(uid).get();
    if (userDoc.exists &&
        userDoc.data() != null &&
        (userDoc.data() as Map<String, dynamic>)['balance'] != null) {
      return (userDoc.data() as Map<String, dynamic>)['balance'].toDouble();
    } else {
      return 0.0;
    }
  }

  @override
  Future<Map<String, double>> getGastos(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('house').doc(uid).get();
    if (userDoc.exists &&
        userDoc.data() != null &&
        (userDoc.data() as Map<String, dynamic>)['gastos'] != null) {
      Map<String, dynamic> gastosData =
          (userDoc.data() as Map<String, dynamic>)['gastos'];
      return gastosData.map((key, value) => MapEntry(key, value.toDouble()));
    } else {
      return {};
    }
  }

  @override
  Future<Map<String, double>> getGanhos(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('house').doc(uid).get();
    if (userDoc.exists &&
        userDoc.data() != null &&
        (userDoc.data() as Map<String, dynamic>)['ganhos'] != null) {
      Map<String, dynamic> ganhosData =
          (userDoc.data() as Map<String, dynamic>)['ganhos'];
      return ganhosData.map((key, value) => MapEntry(key, value.toDouble()));
    } else {
      return {};
    }
  }

  @override
  Future<Map<String, double>> getTotalSpentByCategory(String uid) async {
    // 1. Pegue os valores de cada categoria.
    DocumentSnapshot userDoc =
        await _firestore.collection('house').doc(uid).get();
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
    Map<String, double> categoryExpenses =
        (userData['categoryExpenses'] as Map<String, dynamic>?)
                ?.map((key, value) => MapEntry(key, value.toDouble())) ??
            {};

    // 2. Pegue o valor total (neste caso, os ganhos).
    Map<String, double> monthlyGains = (await getGanhos(uid))
        .map((key, value) => MapEntry(key, value.toDouble()));
    double totalGains =
        monthlyGains.values.fold(0.0, (prev, curr) => prev + curr);

    // 3. Calcule a porcentagem de cada categoria em relação ao valor total.
    Map<String, double> percentages = {};
    categoryExpenses.forEach((category, value) {
      percentages[category] = (value / totalGains) * 100;
    });

    return percentages;
  }

  @override
  Future<List<AccountModel>> getAccountBanks(String houseId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('house')
          .doc(houseId)
          .collection('accountBanks')
          .get();

      List<AccountModel> accountBanks = [];

      for (var doc in querySnapshot.docs) {
        AccountModel account =
            AccountModel.fromJson(doc.data() as Map<String, dynamic>);
        accountBanks.add(account);
      }

      return accountBanks;
    } catch (e) {
      if (kDebugMode) {
        print("Erro ao buscar os bancos: $e");
      }
      return [];
    }
  }
}
