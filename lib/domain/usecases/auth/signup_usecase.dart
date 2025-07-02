import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<UserCredential> call(String email, String password) {
    return repository.signUp(email, password);
  }
}
