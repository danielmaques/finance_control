import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

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

  Future<Map<String, double>> getTotalSpentByCategory(String uid) async {
    DateTime now = DateTime.now();
    String monthYear = DateFormat('MMM yyyy').format(now);

    QuerySnapshot snapshot = await _firestore
        .collection('house')
        .doc(uid)
        .collection(monthYear)
        .get();

    List<Map<String, dynamic>> transactions =
        snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    Map<String, double> categoryTotals = {};

    for (var transaction in transactions) {
      String category = transaction['categoria'];
      double value = transaction['valor'] ?? 0.0;

      if (categoryTotals.containsKey(category)) {
        categoryTotals[category] = (categoryTotals[category] ?? 0.0) +
            value; // Adicionado o null check aqui
      } else {
        categoryTotals[category] = value;
      }
    }

    return categoryTotals;
  }
}
