import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserCredential> signUp(String email, String password) {
    return remoteDataSource.signUp(email, password);
  }

  @override
  Future<UserCredential> login(String email, String password) {
    return remoteDataSource.login(email, password);
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }

  @override
  User? getCurrentUser() {
    return remoteDataSource.getCurrentUser();
  }

  @override
  Stream<User?> get authStateChanges => remoteDataSource.authStateChanges;
}
