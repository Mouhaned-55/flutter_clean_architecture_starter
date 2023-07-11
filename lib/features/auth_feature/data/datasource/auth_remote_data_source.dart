import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_authentication_starter/core/constants.dart';
import 'package:flutter_authentication_starter/core/errors/exception.dart';
import 'package:flutter_authentication_starter/core/utils/handle_server_failure.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/pref_utils.dart';
import '../../interceptor/HttpInterceptor.dart';

abstract class AuthRemoteDataSource {
  Future<Unit> login(String email, String password);

  Future<Unit> register(
      String email, String username, String password, String passwordConfirm);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;
  final HttpInterceptor httpClient;
  final PrefUtils prefUtils;

  AuthRemoteDataSourceImpl(
      {required this.client,
      required this.httpClient,
      required this.prefUtils});

  @override
  Future<Unit> login(String email, String password) async {
    final body = {"email": email, "password": password};

    final response = await client.post(Uri.parse("${BASE_URL}/login"),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json; charset=utf-8'});

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodedJson = json.decode(response.body);
      prefUtils.setToken(decodedJson["payload"]["token"]);
      prefUtils.setLogin(true);
      return Future.value(unit);
    } else {
      throw ServerException(message: getErrorMessage(response));
    }
  }

  @override
  Future<Unit> register(String email, String username, String password,
      String passwordConfirm) async {
    final body = {
      "email": email,
      "username": username,
      "password": password,
      "passwordConfirm": passwordConfirm
    };

    final response = await client.post(Uri.parse("${BASE_URL}/register"),
        body: body, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException(message: getErrorMessage(response));
    }
  }
}
