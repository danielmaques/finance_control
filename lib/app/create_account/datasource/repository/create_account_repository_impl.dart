import '../../../../core/model/user_model.dart';
import '../data/create_account_data.dart';
import 'create_account_repository.dart';

class CreateAccountRepositoryImpl implements CreateAccountRepository {
  final CreateAccountData createAccountData;

  CreateAccountRepositoryImpl(this.createAccountData);

  @override
  Future<UserModel> signUp(String email, String password) async {
    final userCredential = await createAccountData.signUp(email, password);
    return UserModel(
      id: userCredential.user!.uid,
      email: userCredential.user!.email!,
    );
  }
}
