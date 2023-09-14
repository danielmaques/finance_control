import 'package:cloud_firestore/cloud_firestore.dart';

import 'transactions_data.dart';

class TransactionsDataImpl implements TransactionsData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Map<String, dynamic>>> getTransaction(String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();
    List<String> subcollections =
        List<String>.from(userDoc['subcollections'] ?? []);

    List<Map<String, dynamic>> allTransactions = [];

    for (var subcollection in subcollections) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
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
  Future<Map<String, List<Map<String, dynamic>>>> listTransactionMonths(
      String uid) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(uid).get();
    List<String> subcollections =
        List<String>.from(userDoc['subcollections'] ?? []);

    Map<String, List<Map<String, dynamic>>> transactionsByMonth = {};

    for (var subcollection in subcollections) {
      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .doc(uid)
          .collection(subcollection)
          .get();

      transactionsByMonth[subcollection] = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    }

    return transactionsByMonth;
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
