import '../../../../core/model/user_model.dart';
import '../../datasource/repository/create_account_repository.dart';
import 'create_account_usecase.dart';

class CreateAccountUseCaseImpl implements CreateAccountUseCase {
  final CreateAccountRepository createAccountRepository;

  CreateAccountUseCaseImpl(this.createAccountRepository);

  @override
  Future<UserModel> signUp(String email, String password) async {
    return await createAccountRepository.signUp(email, password);
  }
}
