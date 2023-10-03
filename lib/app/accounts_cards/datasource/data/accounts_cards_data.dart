import 'package:finance_control/app/accounts_cards/datasource/model/account_model.dart';
import 'package:finance_control/app/accounts_cards/datasource/model/card_model.dart';

abstract class AccountCardsData {
  Future<List<dynamic>> getUsersInHouse(String houseId);
  Future<String> addBank(String houseId, AccountModel account);
  Future<List<AccountModel>> getAccountBanks(String houseId);
  Future<void> deleteBank(String houseId, String accountId);
  Future<String> addCard(String houseId, CardModel card);
  Future<List<CardModel>> getCards(String houseId);
}
