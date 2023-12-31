import 'package:finance_control/core/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginUseCase {
  Future<UserModel> login(String email, String password);
  Future<String?> findHouseIdByUserId(String userId);
  Future<void> resetPassword(String email);
  Future<UserCredential?> loginWithGoogle();
}
