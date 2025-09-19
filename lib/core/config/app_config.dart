/// Application configuration and settings
class AppConfig {
  /// Whether the app is in debug mode
  static const bool isDebug = true;
  
  /// Whether to use mock data instead of real API calls
  static bool useMockData = false;
  
  /// Whether to enable detailed API logging
  static bool enableApiLogging = isDebug;
  
  /// Whether to show API response times
  static bool showApiTiming = isDebug;
  
  /// Base URL for Jikan API v4
  static const String jikanBaseUrl = 'https://api.jikan.moe/v4';
  
  /// Base URL for RanobeDB API
  static const String ranobeDbBaseUrl = 'https://api.ranobedb.org/api/v0';
  
  /// Network timeout configurations
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  
  /// Toggle mock data usage
  static void toggleMockData() {
    useMockData = !useMockData;
  }
  
  /// Toggle API logging
  static void toggleApiLogging() {
    enableApiLogging = !enableApiLogging;
  }
  
  /// Toggle API timing display
  static void toggleApiTiming() {
    showApiTiming = !showApiTiming;
  }
}