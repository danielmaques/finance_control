abstract class AddTransactionUseCase {
  Future<void> addTransaction(
      String uid, Map<String, dynamic> transactionData, bool add);
  Future<List<dynamic>> getCategories();
  Future<List<dynamic>> getPayments();
  Future<void> updateBalance(String houseId, double valor, bool add);
  Future<void> updateAccountBalance(
      String houseId, String bank, double valor, bool add);
  Future<void> updateCategoryExpense(String uid, String category, double value);
  Future<List<String>> getAccountBanks(String houseId);
}
