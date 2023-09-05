import 'package:firebase_auth/firebase_auth.dart';

abstract class CreateAccountData {
  Future<UserCredential> signUp(String email, String password);
}
