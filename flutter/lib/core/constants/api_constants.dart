/// API constants for the TopAnimes application
class ApiConstants {
  /// Base URL for the Jikan API
  static const String baseUrl = 'https://api.jikan.moe/v3';
  
  /// Endpoint for top anime
  static const String topAnimeEndpoint = '/top/anime/1/upcoming';
  
  /// Complete URL for fetching top anime
  static const String topAnimeUrl = '$baseUrl$topAnimeEndpoint';
  
  /// Connection timeout in milliseconds
  static const int connectionTimeout = 30000;
  
  /// Receive timeout in milliseconds
  static const int receiveTimeout = 30000;
}