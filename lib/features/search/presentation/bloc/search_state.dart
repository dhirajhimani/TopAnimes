import 'package:equatable/equatable.dart';
import '../../../../domain/entities/content.dart';

/// Base class for all search states
abstract class SearchState extends Equatable {
  const SearchState();
  
  @override
  List<Object> get props => [];
}

/// Initial state when search screen is first loaded
class SearchInitial extends SearchState {
  const SearchInitial();
}

/// State when search is in progress
class SearchLoading extends SearchState {
  /// Current search query
  final String query;
  
  const SearchLoading(this.query);
  
  @override
  List<Object> get props => [query];
}

/// State when search results have been loaded
class SearchLoaded extends SearchState {
  /// Search query
  final String query;
  
  /// Search results grouped by content type
  final Map<ContentType, List<Content>> results;
  
  /// Creates a [SearchLoaded] state
  const SearchLoaded({
    required this.query,
    required this.results,
  });
  
  @override
  List<Object> get props => [query, results];
  
  /// Gets total number of results
  int get totalResults => results.values.fold(0, (sum, list) => sum + list.length);
  
  /// Gets results for a specific content type
  List<Content> getResultsForType(ContentType type) {
    return results[type] ?? [];
  }
}

/// State when search encounters an error
class SearchError extends SearchState {
  /// Search query that failed
  final String query;
  
  /// Error message
  final String message;
  
  /// Creates a [SearchError] state
  const SearchError({
    required this.query,
    required this.message,
  });
  
  @override
  List<Object> get props => [query, message];
}