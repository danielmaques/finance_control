import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance_control/app/transactions/datasource/model/transaction_model.dart';
import 'package:finance_control/core/core.dart';

abstract class IGetTransactionsData {
  Future<Result<List<TransactionModel>>> call(String uid);
}

class GetTransactionsData implements IGetTransactionsData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Result<List<TransactionModel>>> call(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('house').doc(uid).get();

      List<String> subcollections =
          List<String>.from(userDoc['subcollections'] ?? []);

      List<TransactionModel> allTransactions = [];

      for (var subcollection in subcollections) {
        QuerySnapshot querySnapshot = await _firestore
            .collection('house')
            .doc(uid)
            .collection(subcollection)
            .get();

        allTransactions.addAll(
          querySnapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final timestamp = data['time'] as Timestamp?;
            final time = timestamp?.toDate();
            return TransactionModel(
              add: data['add'],
              category: data['category'],
              time: time,
              description: data['description'],
              value: data['value'],
              method: data['method'],
              creditCard: data['creditCard'],
            );
          }).toList(),
        );
      }

      return ResultSuccess(allTransactions);
    } catch (e) {
      return ResultError(BaseError('Error: $e'));
    }
  }
}
