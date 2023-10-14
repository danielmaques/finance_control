import 'package:finance_control/app/add_transaction/domain/usecase/get_account_bank_usecase.dart';
import 'package:finance_control/core/states/base_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAccountBankBloc extends Cubit<BaseState> {
  IAccountBankBloc() : super(const EmptyState());

  Future<void> getAccountBank();
}

class AccountBankBloc extends IAccountBankBloc {
  final IGetAccountBankUseCase getAccountBankUseCase;

  AccountBankBloc(this.getAccountBankUseCase);

  @override
  Future<void> getAccountBank() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    emit(const LoadingState());

    final result = await getAccountBankUseCase(houseId!);

    try {
      emit(SuccessState(result.getSuccessData));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
