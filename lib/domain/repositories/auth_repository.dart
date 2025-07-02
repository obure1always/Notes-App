 import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> signUp(String email, String password);
  Future<UserCredential> login(String email, String password);
  Future<void> logout();
  User? getCurrentUser();
  Stream<User?> get authStateChanges;
}
