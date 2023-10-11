import 'package:finance_control/app/home/domain/usecase/get_accounts_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/core.dart';

abstract class IAccountsBloc extends Cubit<BaseState> {
  IAccountsBloc() : super(const EmptyState());

  Future<void> getAccounts();
}

class AccountsBloc extends IAccountsBloc {
  final IGetAccountsUseCase getAccountsUseCase;

  AccountsBloc(
    this.getAccountsUseCase,
  );

  @override
  Future<void> getAccounts() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    emit(const LoadingState());

    try {
      final result = await getAccountsUseCase(houseId!);
      emit(SuccessState(result.getSuccessData));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
