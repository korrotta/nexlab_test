import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthService {
  // Mock user database
  final List<Map<String, String>> _mockUsers = [
    {
      'id': '1',
      'email': 'admin@nexlab.com',
      'password': 'admin123',
      'name': 'Admin User',
    },
    {
      'id': '2',
      'email': 'user@nexlab.com',
      'password': 'user123',
      'name': 'Test User',
    },
    {
      'id': '3',
      'email': 'demo@nexlab.com',
      'password': 'demo123',
      'name': 'Demo User',
    },
  ];

  UserModel? _currentUser;

  Future<UserModel> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));

    // Validate email
    if (!email.contains('@')) {
      throw Exception('Invalid email format');
    }

    // Validate password
    if (password.length < 6) {
      throw Exception('Password must be at least 6 characters');
    }

    // Find user in mock database
    try {
      final userMap = _mockUsers.firstWhere(
        (user) => user['email'] == email && user['password'] == password,
      );

      // Create user model
      final user = UserModel(
        id: userMap['id']!,
        email: userMap['email']!,
        name: userMap['name']!,
      );

      debugPrint('User: $user');
      _currentUser = user;
      return user;
    } catch (e) {
      throw Exception('Invalid email or password');
    }
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 2));
    _currentUser = null;
  }

  UserModel? getCurrentUser() {
    return _currentUser;
  }
}
