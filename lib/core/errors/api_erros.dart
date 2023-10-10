// ignore_for_file: overridden_fields

import 'base_error.dart';

class ApiErrors extends BaseError {
  @override
  String message;

  ApiErrors({this.message = ''}) : super(message);
}
