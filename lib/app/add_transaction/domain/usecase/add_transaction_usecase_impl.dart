import '../../data/repository/add_transaction_repository.dart';
import 'add_transaction_usecase.dart';

class AddTransactionUseCaseImpl implements AddTransactionUseCase {
  final AddTransactionRepository _repository;

  AddTransactionUseCaseImpl(this._repository);

  @override
  Future<void> addTransaction(
          String uid, Map<String, dynamic> transactionData, add) =>
      _repository.addTransaction(uid, transactionData, add);

  @override
  Future<List<dynamic>> getCategories() {
    return _repository.getCategories();
  }

  @override
  Future<List> getPayments() {
    return _repository.getPayments();
  }

  @override
  Future<void> updateCategoryExpense(
      String uid, String category, double value) {
    return _repository.updateCategoryExpense(uid, category, value);
  }

  @override
  Future<List<String>> getAccountBanks(String houseId) {
    return _repository.getAccountBanks(houseId);
  }

  @override
  Future<void> updateAccountBalance(
      String houseId, String bank, double valor, bool add) {
    return _repository.updateAccountBalance(houseId, bank, valor, add);
  }

  @override
  Future<void> updateBalance(String houseId, double valor, bool add) {
    return _repository.updateBalance(houseId, valor, add);
  }
}
