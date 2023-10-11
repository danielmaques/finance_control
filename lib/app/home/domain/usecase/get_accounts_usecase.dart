import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';
import 'package:finance_control/app/home/datasource/data/get_accounts_data.dart';

import '../../../../core/core.dart';

abstract class IGetAccountsUseCase {
  Future<Result<List<AccountModel>>> call(String uid);
}

class GetAccountsUseCase implements IGetAccountsUseCase {
  final IGetAccountsData dataSource;

  GetAccountsUseCase(this.dataSource);

  @override
  Future<Result<List<AccountModel>>> call(String uid) {
    return dataSource(uid);
  }
}
