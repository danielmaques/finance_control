import '../../datasource/repository/transactions_repository.dart';
import 'transactions_usecase.dart';

class TransactionsUseCaseImpl implements TransactionsUseCase {
  final TransactionsRepository transactionsRepository;

  TransactionsUseCaseImpl(this.transactionsRepository);

  @override
  Future<List<Map<String, dynamic>>> getTransaction(String uid) {
    return transactionsRepository.getTransaction(uid);
  }
  
  @override
  Future<Map<String, List<Map<String, dynamic>>>> listTransactionMonths(String uid) {
    return transactionsRepository.listTransactionMonths(uid);
  }
  
  @override
  Future<double> getBalance(String uid) {
    return transactionsRepository.getBalance(uid);
  }

  
}
