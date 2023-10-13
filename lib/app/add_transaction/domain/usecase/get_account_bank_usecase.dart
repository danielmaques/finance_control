import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';
import 'package:finance_control/app/add_transaction/data/datasource/get_account_bank_data.dart';

import '../../../../core/core.dart';

abstract class IGetAccountBankUseCase{
  Future<Result<List<AccountModel>>> call(String uid);
}

class GetAccountBankUseCase implements IGetAccountBankUseCase {
  final IGetAccountBankData data;

  GetAccountBankUseCase(this.data);

  @override
  Future<Result<List<AccountModel>>> call(String uid) async {
    return data(uid);
  }
}