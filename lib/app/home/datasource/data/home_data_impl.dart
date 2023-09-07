import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'home_data.dart';

class HomeDataImpl implements HomeData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  @override
  Future<void> addTransaction(
      String uid, Map<String, dynamic> transactionData, String money) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('transaction')
        .add(transactionData);
  }

  @override
  Future<void> updateBalance(String uid, double valor, String money) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();
    double currentBalance = 0.0;

    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    if (userDoc.exists && userData['balance'] != null) {
      currentBalance = userData['balance'].toDouble();
    }

    if (money == "add") {
      currentBalance += valor;
    } else if (money == "remove") {
      currentBalance -= valor;
    }

    await _firestore.collection('users').doc(uid).update({
      'balance': currentBalance,
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getTransaction(String uid) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('transaction')
        .get();

    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
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
        await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists &&
        userDoc.data() != null &&
        (userDoc.data() as Map<String, dynamic>)['balance'] != null) {
      return (userDoc.data() as Map<String, dynamic>)['balance'].toDouble();
    } else {
      return 0.0;
    }
  }
}
