abstract class AddTransactionUseCase {
  Future<void> addTransaction(
      String uid, Map<String, dynamic> transactionData, bool add);
  Future<List<dynamic>> getCategories();
  Future<List<dynamic>> getPayments();
  Future<void> updateBalance(String uid, double valor, bool add);
}
