import 'package:finance_control/app/transactions/domain/usecase/get_transaction_usecase.dart';
import 'package:finance_control/core/states/base_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ITransactionsBloc extends Cubit<BaseState> {
  ITransactionsBloc() : super(const EmptyState());

  Future<void> getTransactions();
}

class TransactionsBloc extends ITransactionsBloc {
  final IGetTransactionsUseCase useCase;

  TransactionsBloc(this.useCase);

  @override
  Future<void> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    emit(const LoadingState());

    try {
      final result = await useCase(houseId!);
      emit(SuccessState(result.getSuccessData));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
