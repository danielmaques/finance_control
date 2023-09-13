import 'package:finance_control/app/add_transaction/data/datasource/add_transaction_datasource.dart';

import 'add_transaction_repository.dart';

class AddTransactionRepositoryImpl implements AddTransactionRepository {
  final AddTransactionData _dataSource;

  AddTransactionRepositoryImpl(this._dataSource);

  @override
  Future<void> addTransaction(
          String uid, Map<String, dynamic> transactionData, bool add) =>
      _dataSource.addTransaction(uid, transactionData, add);

  @override
  Future<List<dynamic>> getCategories() {
    return _dataSource.getCategories();
  }
  
  @override
  Future<List> getPayments() {
    return _dataSource.getPayments();
  }
  
  @override
  Future<void> updateBalance(String uid, double valor, bool add) {
    return _dataSource.updateBalance(uid, valor, add);
  }
}
