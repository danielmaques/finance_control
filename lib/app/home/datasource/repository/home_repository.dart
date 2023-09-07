import 'dart:io';

abstract class HomeRepository {
  Future<void> addTransaction(
      String uid, Map<String, dynamic> transactionData, String money);
  Future<void> updateBalance(String uid, double valor, String money);
  Future<List<Map<String, dynamic>>> getTransaction(String uid);
  Future<String> upload(File imageFile, String uid);
  Future<double> getBalance(String uid);
}
