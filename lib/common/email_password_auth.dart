import 'dart:async';

import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';

import '../models/profile.dart';
import 'api_errors.dart';

class EmailPasswordAuth {
  static EmailPasswordAuth instance = EmailPasswordAuth._();

  EmailPasswordAuth._();

  StreamController<UserModel?> logStatusStreamController = () {
    var controller = StreamController<UserModel?>();
    controller.add(null);
    return controller;
  }();

  Stream<UserModel?> authStateChanges() {
    return logStatusStreamController.stream;
  }

  Future<void> signInWithEmailPassword(String email, String password) async {
    var host = Uri.parse('https://wr.raneddo.ml/api/Auth/login');
    Response r = await post(
        host,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userName': email,
          'password': password
        }),
    );

    if (r.statusCode == 200) {
      var body = const JsonDecoder().convert(r.body) as Map<String, dynamic>;
      var token = body['access_token'] as String;
      token = 'Bearer $token';
      logStatusStreamController.add(
          UserModel(profile: ProfileModel.fromJson(body['profile']), token: token)
      );
    } else if (r.statusCode == 400) {
      throw BadCredentials();
    } else {
      throw BadResponseCode(statusCode: r.statusCode);
    }
  }

  Future<void> signUpWithBasicData(ProfileModel userData, String password) async {
    var credentials = {
      'name': userData.firstName,
      'email': userData.email,
      'country': userData.country,
      'password': password
    };

    var host = Uri.parse('to-be-replaced');
    Response r = await post(host, body: credentials);

    print(r.statusCode);
    print(r);

    if (r.statusCode == 200) {
      var body = r.body;
      throw MessageUp(message: body);
    } else if (r.statusCode == 401) {
      throw BadCredentials();
    } else {
      throw BadResponseCode(statusCode: r.statusCode);
    }
  }

  Future<void> signOut() async {
    logStatusStreamController.add(null);
  }
}

class MockEmailPasswordAuth extends EmailPasswordAuth {
  static MockEmailPasswordAuth instance = MockEmailPasswordAuth._();

  MockEmailPasswordAuth._(): super._();

  @override
  Future<void> signInWithEmailPassword(String email, String password) async {
    print('Mock auth: try to login as $email');
    logStatusStreamController.add(
      UserModel(
        profile: ProfileModel.getRandom(n: 1).first
            .copyWith(email: email),
        token: ''
      )
    );
  }

  @override
  Future<void> signUpWithBasicData(ProfileModel userData, String password) async {
    var generator = Random();
    if (generator.nextBool()) {
      throw MessageUp(message: 'body');
    } else if (generator.nextBool()) {
      throw BadCredentials();
    } else {
      throw BadResponseCode(statusCode: 999);
    }
  }
}

class UserModel {
  UserModel({this.profile, required this.token});
  String token;
  ProfileModel? profile;
}
