import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

/// Network client for making HTTP requests
class NetworkClient {
  late final Dio _dio;
  
  /// Creates a [NetworkClient] with default configuration
  NetworkClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: Duration(milliseconds: ApiConstants.connectionTimeout),
        receiveTimeout: Duration(milliseconds: ApiConstants.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) {
        // In debug mode, print network logs
        // ignore: avoid_print
        print(object);
      },
    ));
  }
  
  /// Makes a GET request to the specified endpoint
  Future<Response<T>> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _dio.get<T>(
      endpoint,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
  
  /// Disposes the network client
  void dispose() {
    _dio.close();
  }
}