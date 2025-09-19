/// Storage keys for local data persistence
class StorageKeys {
  /// Key for storing anime list in shared preferences
  static const String animeListKey = 'anime_list';
  
  /// Key for storing last update timestamp
  static const String lastUpdateKey = 'last_update';
  
  /// Cache duration in hours
  static const int cacheHours = 24;
}