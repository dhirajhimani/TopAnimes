import 'package:equatable/equatable.dart';

/// Abstract base class for all use cases
abstract class UseCase<Type, Params> {
  /// Executes the use case with the given parameters
  Future<Type> call(Params params);
}

/// Class to represent no parameters for use cases
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}