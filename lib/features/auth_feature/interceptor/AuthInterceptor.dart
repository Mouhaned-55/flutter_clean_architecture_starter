import 'package:http_interceptor/http/http.dart';
import 'package:http_interceptor/models/request_data.dart';
import 'package:http_interceptor/models/response_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/errors/exception.dart';
import '../../../core/utils/handle_server_failure.dart';


class AuthenticatedHttpClient extends InterceptorContract {
  SharedPreferences sharedPref;

  AuthenticatedHttpClient({required this.sharedPref});

  // Use a memory cache to avoid local storage access in each call
  String _inMemoryToken = '';

  String get userAccessToken {
    // use in memory token if available
    if (_inMemoryToken.isNotEmpty) return _inMemoryToken;

    // otherwise load it from local storage
    _inMemoryToken = _loadTokenFromSharedPreference();

    return _inMemoryToken;
  }

  String _loadTokenFromSharedPreference() {
    return sharedPref.getString("token") ?? "";
  }

  // Don't forget to reset the cache when logging out the user
  void reset() {
    _inMemoryToken = '';
  }

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // intercept each call and add the Authorization header if token is available
    if (userAccessToken.isNotEmpty) {
      if (data.headers.containsKey("Authorization")) {
        data.headers.update('Authorization', (_) => 'Bearer $userAccessToken');
      }

      if (data.headers.containsKey("authorizationuser")) {
        data.headers
            .update('authorizationuser', (_) => 'Bearer $userAccessToken');
      }
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("status code ${data.statusCode}");
    if (sharedPref.getBool("login") != null &&
        sharedPref.getBool("login") == true &&
        data.statusCode == 401) {
      print("login");
    } else {
      print("horsLogin");
      if ((data.statusCode == 401 || data.statusCode == 403) &&
          errorMessageToLogout(getErrorMessage(data.toHttpResponse())) &&
          _inMemoryToken.isNotEmpty) {
        throw TokenException();
      }
    }
    return data;
  }
}
