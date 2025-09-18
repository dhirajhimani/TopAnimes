import 'package:equatable/equatable.dart';

/// Base class for all application failures
abstract class Failure extends Equatable {
  /// Message describing the failure
  final String message;
  
  /// Creates a [Failure] with the given message
  const Failure(this.message);
  
  @override
  List<Object> get props => [message];
}

/// Failure that occurs when there's a server error
class ServerFailure extends Failure {
  /// Creates a [ServerFailure] with the given message
  const ServerFailure(super.message);
}

/// Failure that occurs when there's a network connectivity issue
class NetworkFailure extends Failure {
  /// Creates a [NetworkFailure] with the given message
  const NetworkFailure(super.message);
}

/// Failure that occurs when caching data locally fails
class CacheFailure extends Failure {
  /// Creates a [CacheFailure] with the given message
  const CacheFailure(super.message);
}

/// Failure that occurs when data parsing fails
class ParsingFailure extends Failure {
  /// Creates a [ParsingFailure] with the given message
  const ParsingFailure(super.message);
}