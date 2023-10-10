// ignore_for_file: overridden_fields

import 'package:finance_control/core/errors/base_error.dart';

abstract class Result<T> {
  T? _success;
  BaseError? _error;

  Result(Object object) {
    if (object is ResultSuccess) {
      _success = object as T;
    }

    if (object is ResultError) {
      _error = object as BaseError;
    }
  }

  bool get isSuccess => _success != null;

  bool get isError => _error != null;

  T get getSuccessData => _success!;

  BaseError get getErrorData => _error!;
}

class ResultSuccess<S> extends Result<S> {
  @override
  final S _success;

  ResultSuccess(this._success) : super(_success!);
}

class ResultError<E> extends Result<E> {
  @override
  final BaseError _error;

  ResultError(this._error) : super(_error);
}

class ResultErrorList<E> extends Result<E> {
  // ignore: unused_field
  final List<BaseError> _errors;

  ResultErrorList(this._errors) : super(_errors);
}
