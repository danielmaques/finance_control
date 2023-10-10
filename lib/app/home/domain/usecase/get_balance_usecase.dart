import '../../../../core/core.dart';
import '../../datasource/data/get_balance_data.dart';
import '../../datasource/model/balance_model.dart';

abstract class IGetBalanceUseCase {
  Future<Result<BalanceModel>> call(String uid);
}

class GetBalanceUseCase implements IGetBalanceUseCase {
  final IGetBalanceData dataSource;

  GetBalanceUseCase(this.dataSource);

  @override
  Future<Result<BalanceModel>> call(String uid) {
    return dataSource(uid);
  }
}
