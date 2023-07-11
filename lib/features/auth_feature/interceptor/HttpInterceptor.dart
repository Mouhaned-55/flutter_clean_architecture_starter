import 'package:http/io_client.dart';
import 'package:http_interceptor/http/intercepted_http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'AuthInterceptor.dart';
import 'dart:io';

abstract class HttpInterceptor {
  InterceptedHttp httpInterceptor();
}

class HttpInterceptorImpl implements HttpInterceptor {
  final AuthenticatedHttpClient httpClient;

  const HttpInterceptorImpl({
    required this.httpClient,
  });

  @override
  InterceptedHttp httpInterceptor() {
    final client = HttpClient()
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    final ioClient = IOClient(client);
    return InterceptedHttp.build(
      client: ioClient,
      interceptors: [httpClient],
    );
  }
}
