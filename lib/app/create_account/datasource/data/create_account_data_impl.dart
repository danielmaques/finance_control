import 'package:finance_control/app/create_account/datasource/data/create_account_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccountDataImpl implements CreateAccountData {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
