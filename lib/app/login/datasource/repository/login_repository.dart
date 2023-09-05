import 'package:finance_control/core/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  Future<UserModel> login(String email, String password);
}
