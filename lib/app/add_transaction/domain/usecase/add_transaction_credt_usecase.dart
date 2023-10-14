import 'package:finance_control/app/add_transaction/data/datasource/add_transaction_credt_data.dart';
import 'package:finance_control/app/add_transaction/data/model/add_transaction_card_model.dart';
import 'package:finance_control/core/core.dart';

abstract class IAddTransactionCredtUseCase {
  Future<Result> call(String uid, AddTransactionCard addTransactionCard);
}

class AddTransactionCredtUseCase implements IAddTransactionCredtUseCase {
  final IAddTransactionCardData data;

  AddTransactionCredtUseCase(this.data);

  @override
  Future<Result> call(String uid, AddTransactionCard addTransaction) {
    return data(uid, addTransaction);
  }
}
