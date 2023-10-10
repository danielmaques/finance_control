import 'package:finance_control/app/home/domain/usecase/get_balance_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';

abstract class IBalanceBloc extends Cubit<BaseState> {
  IBalanceBloc() : super(const EmptyState());

  Future<void> getBalance();
}

class BalanceBloc extends IBalanceBloc {
  final IGetBalanceUseCase getBalanceUseCase;

  BalanceBloc(
    this.getBalanceUseCase,
  );

  @override
  Future<void> getBalance() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    emit(const LoadingState());

    final result = await getBalanceUseCase(houseId!);
    emit(SuccessState(result.getSuccessData));
  }
}
