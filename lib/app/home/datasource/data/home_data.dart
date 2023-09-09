import 'dart:io';

abstract class HomeData {
  Future<void> addTransaction(
      String uid, Map<String, dynamic> transactionData, bool add);
  Future<void> updateBalance(String uid, double valor, bool add);
  Future<List<Map<String, dynamic>>> getTransaction(String uid);
  Future<String> upload(File imageFile, String uid);
  Future<double> getBalance(String uid);
  Future<Map<String, double>> getGastos(String uid);
  Future<Map<String, double>> getGanhos(String uid);
}
