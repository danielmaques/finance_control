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
  Future<void> updateCategoryExpense(
      String uid, String category, double value) {
    return _dataSource.updateCategoryExpense(uid, category, value);
  }

  @override
  Future<List<String>> getAccountBanks(String houseId) {
    return _dataSource.getAccountBanks(houseId);
  }

  @override
  Future<void> updateAccountBalance(
      String houseId, String bank, double valor, bool add) {
    return _dataSource.updateAccountBalance(houseId, bank, valor, add);
  }

  @override
  Future<void> updateBalance(String houseId, double valor, bool add) {
    return _dataSource.updateBalance(houseId, valor, add);
  }
}
