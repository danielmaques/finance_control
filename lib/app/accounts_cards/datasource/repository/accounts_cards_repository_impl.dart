import 'package:finance_control/app/accounts_cards/datasource/data/accounts_cards_data.dart';

import 'accounts_cards_repository.dart';

class AccountCardsRepositoryImpl implements AccountCardsRepository {
  final AccountCardsData _accountCardsData;

  AccountCardsRepositoryImpl(this._accountCardsData);

  @override
  Future<List<dynamic>> getUsersInHouse(String houseId) async {
    return await _accountCardsData.getUsersInHouse(houseId);
  }
}
