import '../../datasource/repository/accounts_cards_repository.dart';
import 'accounts_cards_usecase.dart';

class AccountCardsUseCaseImpl implements AccountCardsUseCase {
  final AccountCardsRepository _accountCardsRepository;

  AccountCardsUseCaseImpl(this._accountCardsRepository);

  @override
  Future<List<dynamic>> getUsersInHouse(String houseId) async {
    return await _accountCardsRepository.getUsersInHouse(houseId);
  }
}
