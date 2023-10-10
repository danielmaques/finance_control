import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';

class HomeRefreshBloc extends Cubit<BaseState> {
  HomeRefreshBloc() : super(const EmptyState());

  void call() {
    debugPrint('onRefresh');
    emit(const SuccessState(''));
  }
}
