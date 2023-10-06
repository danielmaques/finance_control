import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';
import 'package:finance_control/app/accounts_cards/datasource/model/card_model.dart';

import '../../datasource/repository/accounts_cards_repository.dart';
import 'accounts_cards_usecase.dart';

class AccountCardsUseCaseImpl implements AccountCardsUseCase {
  final AccountCardsRepository _accountCardsRepository;

  AccountCardsUseCaseImpl(this._accountCardsRepository);

  @override
  Future<List<AccountModel>> getAccountBanks(String houseId) {
    return _accountCardsRepository.getAccountBanks(houseId);
  }

  @override
  Future<void> deleteBank(String houseId, String accountId) {
    return _accountCardsRepository.deleteBank(houseId, accountId);
  }

  @override
  Future<String> addCard(String houseId, CardModel card) {
    return _accountCardsRepository.addCard(houseId, card);
  }

  @override
  Future<List<CardModel>> getCards(String houseId) {
    return _accountCardsRepository.getCards(houseId);
  }
}
