import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginData {
  Future<UserCredential> login(String email, String password);
  Future<String?> findHouseIdByUserId(String userId);
  Future<void> resetPassword(String email);
}
