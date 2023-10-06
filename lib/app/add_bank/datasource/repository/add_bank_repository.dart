import '../../../accounts_cards/datasource/model/account_model.dart';

abstract class AddBankRepository {
  Future<List<dynamic>> getUsersInHouse(String houseId);
  Future<String> addBank(String houseId, AccountModel account);
}
