import 'package:finance_control/app/accounts_cards/datasource/model/card_model.dart';
import 'package:finance_control/app/add_transaction/data/datasource/get_card_data.dart';
import 'package:finance_control/core/core.dart';

abstract class IGetCardUseCase {
  Future<Result<List<CardModel>>> call(String uid);
}

class GetCardUseCase implements IGetCardUseCase {
  final IGetCardData data;

  GetCardUseCase(this.data);

  @override
  Future<Result<List<CardModel>>> call(String uid) async {
    return data(uid);
  }
}
