import 'package:finance_control/core/model/user_model.dart';

abstract class CreateAccountUseCase {
  Future<UserModel> signUp(String email, String password);
}
