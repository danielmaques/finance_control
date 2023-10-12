import 'package:finance_control/app/home/datasource/data/get_transactions_home_data.dart';
import 'package:finance_control/app/home/datasource/model/transactions_model.dart';

import '../../../../core/core.dart';

abstract class IGetTransactionsHomeUseCase {
  Future<Result<List<TransactionsModel>>> call(String uid);
}

class GetTransactionsHomeUseCase implements IGetTransactionsHomeUseCase {
  final IGetTransactionsHomeData dataSource;

  GetTransactionsHomeUseCase(this.dataSource);

  @override
  Future<Result<List<TransactionsModel>>> call(String uid) {
    return dataSource(uid);
  }
}
