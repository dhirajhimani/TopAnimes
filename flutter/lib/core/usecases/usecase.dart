import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

/// Base class for use cases
abstract class UseCase<Type, Params> {
  /// Executes the use case
  Future<Either<Failure, Type>> call(Params params);
}

/// Parameters for use cases that don't need any
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}