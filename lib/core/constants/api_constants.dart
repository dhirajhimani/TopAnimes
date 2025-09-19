/// API constants for the Otaku Hub Lite application
class ApiConstants {
  // Jikan API v4 constants
  /// Base URL for the Jikan API v4
  static const String jikanBaseUrl = 'https://api.jikan.moe/v4';
  
  /// Endpoint for top airing anime
  static const String topAiringAnimeEndpoint = '/top/anime?filter=airing';
  
  /// Endpoint for top manga
  static const String topMangaEndpoint = '/top/manga';
  
  /// Endpoint for anime search
  static const String animeSearchEndpoint = '/anime';
  
  /// Endpoint for manga search
  static const String mangaSearchEndpoint = '/manga';
  
  /// Endpoint for anime details
  static const String animeDetailsEndpoint = '/anime';
  
  /// Endpoint for manga details
  static const String mangaDetailsEndpoint = '/manga';
  
  // RanobeDB API constants
  /// Base URL for the RanobeDB API
  static const String ranobeDbBaseUrl = 'https://api.ranobedb.org/api/v0';
  
  /// Endpoint for light novel search
  static const String lightNovelSearchEndpoint = '/novels';
  
  /// Endpoint for light novel details
  static const String lightNovelDetailsEndpoint = '/novels';
  
  // Network timeouts
  /// Connection timeout in milliseconds
  static const int connectionTimeout = 30000;
  
  /// Receive timeout in milliseconds
  static const int receiveTimeout = 30000;
  
  /// Send timeout in milliseconds
  static const int sendTimeout = 30000;
}