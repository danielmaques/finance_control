import 'package:finance_control/app/add_transaction/data/datasource/add_transaction_data.dart';
import 'package:finance_control/app/add_transaction/data/model/add_transaction_model.dart';
import 'package:finance_control/core/core.dart';

abstract class IAddTransactionUseCase {
  Future<Result> call(String uid, AddTransaction addTransaction);
}

class AddTransactionUseCase implements IAddTransactionUseCase {
  final IAddTransactionData data;

  AddTransactionUseCase(this.data);

  @override
  Future<Result> call(String uid, AddTransaction addTransaction) {
    return data(uid, addTransaction);
  }
}
