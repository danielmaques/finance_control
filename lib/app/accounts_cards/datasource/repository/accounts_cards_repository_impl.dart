import 'package:finance_control/app/accounts_cards/datasource/data/accounts_cards_data.dart';
import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';

import 'accounts_cards_repository.dart';

class AccountCardsRepositoryImpl implements AccountCardsRepository {
  final AccountCardsData _accountCardsData;

  AccountCardsRepositoryImpl(this._accountCardsData);

  @override
  Future<List<dynamic>> getUsersInHouse(String houseId) async {
    return await _accountCardsData.getUsersInHouse(houseId);
  }

  @override
  Future<void> addBank(String houseId, AccountModel account) {
    return _accountCardsData.addBank(houseId, account);
  }
  
  @override
  Future<List<AccountModel>> getAccountBanks(String houseId) {
    return _accountCardsData.getAccountBanks(houseId);
  }
}
