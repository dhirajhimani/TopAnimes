/// Custom exceptions for the TopAnimes application
class ServerException implements Exception {
  /// Message describing the server exception
  final String message;
  
  /// Creates a [ServerException] with the given message
  const ServerException(this.message);
  
  @override
  String toString() => 'ServerException: $message';
}

/// Exception thrown when there's a network connectivity issue
class NetworkException implements Exception {
  /// Message describing the network exception
  final String message;
  
  /// Creates a [NetworkException] with the given message
  const NetworkException(this.message);
  
  @override
  String toString() => 'NetworkException: $message';
}

/// Exception thrown when caching data locally fails
class CacheException implements Exception {
  /// Message describing the cache exception
  final String message;
  
  /// Creates a [CacheException] with the given message
  const CacheException(this.message);
  
  @override
  String toString() => 'CacheException: $message';
}