import 'dart:convert';
import 'dart:math';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:crypto/crypto.dart';
import 'package:tiangou/auth/repository.dart';

import 'user.dart';

final SECURITY_KEY = generateSeurityKey();

String generateSeurityKey() {
  final randomNumber = Random().nextDouble();
  final randomBytes = utf8.encode(randomNumber.toString());
  final randomString = md5.convert(randomBytes).toString();
  return randomString;
}

class Authenticator {
  UserRepository userRepository;

  Authenticator(this.userRepository);

  Future<User?> findByUsernameAndPassword({
    required String username,
    required String password,
  }) async {
    var user = await userRepository.findByUsername(username);
    if (user?.password == password) {
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
      final user = await userRepository.findByUsername(username);
      return user;
    } catch (e) {
      print(e);
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
        'username': username,
      },
    );
    return jwt.sign(SecretKey(SECURITY_KEY),
        expiresIn: const Duration(days: 30));
  }
}
