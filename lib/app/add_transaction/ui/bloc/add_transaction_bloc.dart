import 'package:finance_control/app/add_transaction/data/model/add_transaction_model.dart';
import 'package:finance_control/app/add_transaction/domain/usecase/add_transaction_credt_usecase.dart';
import 'package:finance_control/app/add_transaction/domain/usecase/add_transaction_usecase.dart';
import 'package:finance_control/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAddTransactionBloc extends Cubit<BaseState> {
  IAddTransactionBloc() : super(const EmptyState());

  Future<void> addTransaction(AddTransaction addTransaction);
}

class AddTransactionBloc extends IAddTransactionBloc {
  final IAddTransactionUseCase useCase;
  final IAddTransactionCredtUseCase useCaseCard;

  AddTransactionBloc(this.useCase, this.useCaseCard);

  @override
  Future<void> addTransaction(AddTransaction addTransaction) async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    emit(const LoadingState());

    final result = await useCase(houseId!, addTransaction);

    try {
      emit(SuccessState(result.getSuccessData));

      Modular.to.pushReplacementNamed('/bottomNavigation/homeBottom');
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
