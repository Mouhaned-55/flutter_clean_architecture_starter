import 'dart:convert';
import 'package:http/http.dart';

String getErrorMessage(Response response) {
  final errorDecodedJson = json.decode(response.body) as Map<String, dynamic>;
  final error = errorDecodedJson["message"] as String;
  return error;
}

bool errorMessageToLogout(String message) {
  switch (message) {
    case "Invalid JWT Token":
    case "Expired JWT Token":
    case "Permission denied":
      return true;
    default:
      return false;
  }
}


