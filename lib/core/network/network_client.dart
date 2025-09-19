import 'package:dio/dio.dart';
import '../config/app_config.dart';

/// Network client for making HTTP requests with debug capabilities
class NetworkClient {
  late final Dio _dio;
  
  /// Creates a [NetworkClient] with enhanced configuration
  NetworkClient() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: AppConfig.connectionTimeout,
        receiveTimeout: AppConfig.receiveTimeout,
        sendTimeout: AppConfig.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'OtakuHubLite/1.0',
        },
      ),
    );
    
    // Add logging interceptor based on configuration
    if (AppConfig.enableApiLogging) {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: AppConfig.isDebug,
          responseHeader: AppConfig.isDebug,
          error: true,
          logPrint: (log) {
            if (AppConfig.isDebug) {
              // ignore: avoid_print
              print('🌐 API: $log');
            }
          },
        ),
      );
    }
    
    // Add timing interceptor
    if (AppConfig.showApiTiming) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;
            if (AppConfig.isDebug) {
              // ignore: avoid_print
              print('🚀 API Request: ${options.method} ${options.uri}');
            }
            handler.next(options);
          },
          onResponse: (response, handler) {
            final startTime = response.requestOptions.extra['startTime'] as int?;
            if (startTime != null && AppConfig.isDebug) {
              final duration = DateTime.now().millisecondsSinceEpoch - startTime;
              // ignore: avoid_print
              print('✅ API Response: ${response.statusCode} in ${duration}ms');
            }
            handler.next(response);
          },
          onError: (error, handler) {
            final startTime = error.requestOptions.extra['startTime'] as int?;
            if (startTime != null && AppConfig.isDebug) {
              final duration = DateTime.now().millisecondsSinceEpoch - startTime;
              // ignore: avoid_print
              print('❌ API Error: ${error.response?.statusCode} in ${duration}ms - ${error.message}');
            }
            handler.next(error);
          },
        ),
      );
    }
  }
  
  /// Makes a GET request to the specified URL
  Future<Response<T>> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    if (AppConfig.isDebug) {
      // ignore: avoid_print
      print('📱 GET Request: $url');
      if (queryParameters != null) {
        // ignore: avoid_print
        print('📝 Query Params: $queryParameters');
      }
    }
    
    return _dio.get<T>(
      url,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
  
  /// Makes a POST request to the specified URL
  Future<Response<T>> post<T>(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    if (AppConfig.isDebug) {
      // ignore: avoid_print
      print('📱 POST Request: $url');
    }
    
    return _dio.post<T>(
      url,
      data: data,
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