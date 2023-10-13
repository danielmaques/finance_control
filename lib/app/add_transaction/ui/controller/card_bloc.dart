import 'package:finance_control/app/add_transaction/domain/usecase/get_card_usecase.dart';
import 'package:finance_control/core/states/base_page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ICardBloc extends Cubit<BaseState> {
  ICardBloc() : super(const EmptyState());

  Future<void> getAccountBank();
}

class CardBloc extends ICardBloc {
  final IGetCardUseCase getCardUseCase;

  CardBloc(this.getCardUseCase);

  @override
  Future<void> getAccountBank() async {
    final prefs = await SharedPreferences.getInstance();
    final houseId = prefs.getString('house_id');

    emit(const LoadingState());

    final result = await getCardUseCase(houseId!);

    try {
      emit(SuccessState(result.getSuccessData));
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
