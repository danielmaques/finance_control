abstract class TransactionsUseCase {
  Future<List<Map<String, dynamic>>> getTransaction(String uid);
  Future<Map<String, List<Map<String, dynamic>>>> listTransactionMonths(
      String uid);
  Future<double> getBalance(String uid);
}
