import 'dart:developer';

import 'package:dio/dio.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient({String baseUrl = 'https://api.binance.com/api/v3'}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 35),
        responseType: ResponseType.json,
        headers: {'Accept': 'application/json'},
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('┌───────────────────────────────────────────────');
          log('│ 🚀 [REQUEST]');
          log('│ URL: ${options.uri}');
          log('│ Method: ${options.method}');
          if (options.queryParameters.isNotEmpty) {
            log('│ Query: ${options.queryParameters}');
          }
          if (options.data != null) {
            log('│ Body: ${options.data}');
          }
          log('├───────────────────────────────────────────────');
          handler.next(options);
        },
        onResponse: (response, handler) {
          log('│ ✅ [RESPONSE]');
          log('│ Status: ${response.statusCode}');
          log('│ Data: ${_formatResponse(response.data)}');
          log('└───────────────────────────────────────────────');
          handler.next(response);
        },
        onError: (DioException e, handler) {
          log('│ ❌ [ERROR]');
          log('│ Type: ${e.type}');
          log('│ Message: ${e.message}');
          if (e.response != null) {
            log('│ Status: ${e.response?.statusCode}');
            log('│ Data: ${_formatResponse(e.response?.data)}');
          }
          log('└───────────────────────────────────────────────');
          handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;

  static String _formatResponse(dynamic data) {
    if (data == null) return 'null';
    if (data is Map || data is List) {
      try {
        return data.toString().substring(0, 300); // limit output
      } catch (_) {
        return data.toString();
      }
    }
    return data.toString();
  }
}
