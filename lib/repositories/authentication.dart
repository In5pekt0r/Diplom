import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:webrtc_conference/common/email_password_auth.dart';
import 'package:webrtc_conference/common/helpers.dart';

class SignUpFailure implements Exception {}
class LogInWithEmailAndPasswordFailure implements Exception {}
class LogInWithGoogleFailure implements Exception {}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({EmailPasswordAuth? emailPasswordAuth})
      : _emailPasswordAuth = emailPasswordAuth ?? EmailPasswordAuth.instance;

  final _storage = const FlutterSecureStorage();
  final EmailPasswordAuth _emailPasswordAuth;

  Stream<UserModel?> get user {
    return _emailPasswordAuth
        .authStateChanges()
        .asyncMap((user) async {
          if (user == null) {
            var token = await _storage.read(key: 'token');
            if (token != null) {
              return UserModel(token: token);
            }
            return null;
          } else {
            await _storage.write(key: 'token', value: user.token);
            return user;
          }
      });
  }

  Future<void> signUpWithBasicData({
    required String name,
    required String email,
    required String country,
    required String password,
  }) async {
    try {
      // _emailPasswordAuth.signUpWithBasicData(
      //     ProfileModel(name: name, email: email, country: country),
      //     password
      // );
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> logInWithEmailAndPassword({
    required String? email,
    required String? password,
  }) async {
    if (email == null || email.isEmpty) {
      throw ValidationException('Email field is empty');
    }
    if (password == null || password.isEmpty) {
      throw ValidationException('Password field is empty');
    }
    try {
      await _emailPasswordAuth.signInWithEmailPassword(email, password);
    } on Exception {
      // throw LogInWithEmailAndPasswordFailure();
      rethrow;
    }
  }

  Future<void> logOut() async {
    try {
      await _storage.delete(key: 'token');
      await _emailPasswordAuth.signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }
}

// extension on ProfileModel {
//   UserModel get toUserModel {
//     return UserModel(
//       token: 'token',
//       profile: this
//     );
//   }
// }
