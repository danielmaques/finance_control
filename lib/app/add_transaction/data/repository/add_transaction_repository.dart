abstract class AddTransactionRepository {
  Future<void> addTransaction(
      String uid, Map<String, dynamic> transactionData, bool add);
  Future<List<dynamic>> getCategories();
  Future<List<dynamic>> getPayments();

}
