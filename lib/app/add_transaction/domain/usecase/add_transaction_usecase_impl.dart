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
  Future<void> updateBalance(String uid, double valor, bool add) {
    return _repository.updateBalance(uid, valor, add);
  }
}
