import 'package:finance_control/core/model/user_model.dart';

abstract class CreateAccountRepository {
  Future<UserModel> signUp(String email, String password);
}
