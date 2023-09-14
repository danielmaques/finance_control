import 'package:finance_control/app/transactions/datasource/data/transactions_data.dart';

import 'transactions_repository.dart';

class TransactionsRepositoryImpl implements TransactionsRepository {
  final TransactionsData transactionsData;

  TransactionsRepositoryImpl(this.transactionsData);

  @override
  Future<List<Map<String, dynamic>>> getTransaction(String uid) {
    return transactionsData.getTransaction(uid);
  }
  
  @override
  Future<Map<String, List<Map<String, dynamic>>>> listTransactionMonths(String uid) {
    return transactionsData.listTransactionMonths(uid);
  }
  
  @override
  Future<double> getBalance(String uid) {
    return transactionsData.getBalance(uid);
  }
  
}
