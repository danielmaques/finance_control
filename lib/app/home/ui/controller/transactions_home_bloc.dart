import 'package:finance_control/app/home/domain/usecase/get_transactions_home_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';

abstract class ITransactionsHomeBloc extends Cubit<BaseState> {
  ITransactionsHomeBloc() : super(const EmptyState());

  Future<void> getTransactions();
}

class TransactionsHomeBloc extends ITransactionsHomeBloc {
  final IGetTransactionsHomeUseCase GetTransactionsHomeUseCase;

  TransactionsHomeBloc(
    this.GetTransactionsHomeUseCase,
  );

  @override
  Future<void> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    emit(const LoadingState());

    try {
      final result = await GetTransactionsHomeUseCase(houseId!);
      emit(SuccessState(result.getSuccessData));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
