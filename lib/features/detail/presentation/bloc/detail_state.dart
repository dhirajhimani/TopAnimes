import 'package:equatable/equatable.dart';
import '../../../../domain/entities/content.dart';

/// Base class for all detail states
abstract class DetailState extends Equatable {
  const DetailState();
  
  @override
  List<Object> get props => [];
}

/// Initial state when the detail screen is first loaded
class DetailInitial extends DetailState {
  const DetailInitial();
}

/// State when detail data is being loaded
class DetailLoading extends DetailState {
  /// Content being loaded
  final Content content;
  
  const DetailLoading(this.content);
  
  @override
  List<Object> get props => [content];
}

/// State when detail data has been successfully loaded
class DetailLoaded extends DetailState {
  /// Content with full details
  final Content content;
  
  /// Creates a [DetailLoaded] state
  const DetailLoaded(this.content);
  
  @override
  List<Object> get props => [content];
}

/// State when an error occurred while loading detail data
class DetailError extends DetailState {
  /// Content that failed to load
  final Content content;
  
  /// Error message describing what went wrong
  final String message;
  
  /// Creates a [DetailError] state
  const DetailError({
    required this.content,
    required this.message,
  });
  
  @override
  List<Object> get props => [content, message];
}