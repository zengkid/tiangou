import 'dart:convert';
import 'dart:math';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:crypto/crypto.dart';

import 'user.dart';

final SECURITY_KEY = generateSeurityKey();

String generateSeurityKey() {
  final randomNumber = Random().nextDouble();
  final randomBytes = utf8.encode(randomNumber.toString());
  final randomString = md5.convert(randomBytes).toString();
  return randomString;
}

class Authenticator {
  static const _users = {
    'john': User(
      id: '1',
      username: 'John',
      name: 'John',
      password: '123',
    ),
    'jack': User(
      id: '2',
      username: 'Jack',
      name: 'Jack',
      password: '321',
    ),
  };

  static const _passwords = {
    // ⚠️ Never store user's password in plain text, these values are in plain text
    // just for the sake of the tutorial.
    'john': '123',
    'jack': '321',
  };

  User? findByUsernameAndPassword({
    required String username,
    required String password,
  }) {
    final user = _users[username];

    if (user != null && _passwords[username] == password) {
      return user;
    }

    return null;
  }

  Future<User?> verifyToken(String token) async {
    try {
      final payload = JWT.verify(
        token,
        SecretKey(SECURITY_KEY),
      );

      final payloadData = payload.payload as Map<String, dynamic>;

      final username = payloadData['username'] as String;
      return _users[username];
    } catch (e) {
      return null;
    }
  }

  String generateToken({
    required String username,
    required User user,
  }) {
    final jwt = JWT(
      {
        'id': user.id,
        'name': user.name,
        'username': username,
      },
    );
    return jwt.sign(SecretKey(SECURITY_KEY), expiresIn: const Duration(days: 30));
  }
}
