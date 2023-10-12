import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ITransactionData {
  Future<List<Map<String, dynamic>>> call(String uid);
}

class TransactionData implements ITransactionData {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Future<List<Map<String, dynamic>>> call(String uid) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
