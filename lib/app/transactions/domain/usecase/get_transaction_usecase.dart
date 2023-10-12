import 'package:finance_control/app/transactions/datasource/data/get_transaction_data.dart';
import 'package:finance_control/app/transactions/datasource/model/transaction_model.dart';

import '../../../../core/core.dart';

abstract class IGetTransactionsUseCase {
  Future<Result<List<TransactionModel>>> call(String uid);
}

class GetTransactionsUseCase implements IGetTransactionsUseCase {
  final IGetTransactionsData dataSource;

  GetTransactionsUseCase(this.dataSource);

  @override
  Future<Result<List<TransactionModel>>> call(String uid) {
    return dataSource(uid);
  }
}
