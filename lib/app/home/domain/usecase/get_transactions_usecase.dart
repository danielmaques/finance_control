import 'package:finance_control/app/home/datasource/data/get_transactions_data.dart';
import 'package:finance_control/app/home/datasource/model/transactions_model.dart';

import '../../../../core/core.dart';

abstract class IGetTransactionsUseCase {
  Future<Result<List<TransactionsModel>>> call(String uid);
}

class GetTransactionsUseCase implements IGetTransactionsUseCase {
  final IGetTransactionsData dataSource;

  GetTransactionsUseCase(this.dataSource);

  @override
  Future<Result<List<TransactionsModel>>> call(String uid) {
    return dataSource(uid);
  }
}
