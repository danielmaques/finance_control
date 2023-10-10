import 'package:finance_control/app/home/domain/usecase/get_transactions_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';

abstract class ITransactionsBloc extends Cubit<BaseState> {
  ITransactionsBloc() : super(const EmptyState());

  Future<void> getTransactions();
}

class TransactionsBloc extends ITransactionsBloc {
  final IGetTransactionsUseCase getTransactionsUseCase;

  TransactionsBloc(
    this.getTransactionsUseCase,
  );

  @override
  Future<void> getTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    emit(const LoadingState());

    final result = await getTransactionsUseCase(houseId!);
    emit(SuccessState(result.getSuccessData));
  }
}
