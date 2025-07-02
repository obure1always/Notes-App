import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';
import '../../domain/entities/user.dart';

abstract class AuthLocalDataSource {
  Future<User> signUp(String email, String password);
  Future<User> login(String email, String password);
  Future<void> logout();
  User? getCurrentUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final Uuid uuid = const Uuid();

  static const String usersKey = 'CACHED_USERS';
  static const String currentUserKey = 'CURRENT_USER';

  AuthLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<User> signUp(String email, String password) async {
    // Get existing users
    final users = _getUsers();
    
    // Check if user already exists
    if (users.any((user) => user.email == email)) {
      throw Exception('Email is already registered');
    }

    // Validate email format
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      throw Exception('Invalid email address');
    }

    // Validate password strength
    if (password.length < 6) {
      throw Exception('Password is too weak');
    }

    // Create new user
    final newUser = UserModel(
      id: uuid.v4(),
      email: email,
      password: password,
    );

    // Save user
    users.add(newUser);
    await _saveUsers(users);
    await _saveCurrentUser(newUser);

    return newUser;
  }

  @override
  Future<User> login(String email, String password) async {
    final users = _getUsers();
    
    try {
      final user = users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      
      await _saveCurrentUser(user);
      return user;
    } catch (e) {
      if (users.any((user) => user.email == email)) {
        throw Exception('Incorrect password');
      } else {
        throw Exception('No user found with this email');
      }
    }
  }

  @override
  Future<void> logout() async {
    await sharedPreferences.remove(currentUserKey);
  }

  @override
  User? getCurrentUser() {
    final userString = sharedPreferences.getString(currentUserKey);
    if (userString != null) {
      try {
        final Map<String, dynamic> userMap = json.decode(userString);
        return UserModel.fromJson(userMap);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  List<UserModel> _getUsers() {
    final usersString = sharedPreferences.getString(usersKey);
    if (usersString != null) {
      return UserModel.decodeUsers(usersString);
    }
    return [];
  }

  Future<void> _saveUsers(List<UserModel> users) async {
    final usersString = UserModel.encodeUsers(users);
    await sharedPreferences.setString(usersKey, usersString);
  }

  Future<void> _saveCurrentUser(UserModel user) async {
    final userString = json.encode(user.toJson());
    await sharedPreferences.setString(currentUserKey, userString);
  }
}
