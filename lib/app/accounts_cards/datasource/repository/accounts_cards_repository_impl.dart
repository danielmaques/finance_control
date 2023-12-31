import 'package:finance_control/app/accounts_cards/datasource/data/accounts_cards_data.dart';
import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';
import 'package:finance_control/app/accounts_cards/datasource/model/card_model.dart';

import 'accounts_cards_repository.dart';

class AccountCardsRepositoryImpl implements AccountCardsRepository {
  final AccountCardsData _accountCardsData;

  AccountCardsRepositoryImpl(this._accountCardsData);

  @override
  Future<List<AccountModel>> getAccountBanks(String houseId) {
    return _accountCardsData.getAccountBanks(houseId);
  }

  @override
  Future<void> deleteBank(String houseId, String accountId) {
    return _accountCardsData.deleteBank(houseId, accountId);
  }

  @override
  Future<String> addCard(String houseId, CardModel card) {
    return _accountCardsData.addCard(houseId, card);
  }

  @override
  Future<List<CardModel>> getCards(String houseId) {
    return _accountCardsData.getCards(houseId);
  }
}
