import 'package:finance_control/app/add_bank/domain/usecase/add_bank_usecase.dart';

import '../../../accounts_cards/datasource/model/account_model.dart';
import '../../datasource/repository/add_bank_repository.dart';

class AddBankUseCaseImpl implements AddBankUseCase {
  final AddBankRepository addBankRepository;

  AddBankUseCaseImpl(this.addBankRepository);

  @override
  Future<List<dynamic>> getUsersInHouse(String houseId) async {
    return await addBankRepository.getUsersInHouse(houseId);
  }

  @override
  Future<String> addBank(String houseId, AccountModel account) {
    return addBankRepository.addBank(houseId, account);
  }
}
