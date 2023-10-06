import 'package:finance_control/app/add_bank/datasource/data/add_bank_data.dart';

import '../../../accounts_cards/datasource/model/account_model.dart';
import 'add_bank_repository.dart';

class AddBankRepositoryImpl implements AddBankRepository {
  final AddBankData addBankData;

  AddBankRepositoryImpl(this.addBankData);

  @override
  Future<List<dynamic>> getUsersInHouse(String houseId) async {
    return await addBankData.getUsersInHouse(houseId);
  }

  @override
  Future<String> addBank(String houseId, AccountModel account) {
    return addBankData.addBank(houseId, account);
  }
}
