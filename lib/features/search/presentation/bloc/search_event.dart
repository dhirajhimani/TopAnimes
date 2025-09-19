import 'package:equatable/equatable.dart';

/// Base class for all search events
abstract class SearchEvent extends Equatable {
  const SearchEvent();
  
  @override
  List<Object> get props => [];
}

/// Event to search for content
class SearchContent extends SearchEvent {
  /// Search query
  final String query;
  
  const SearchContent(this.query);
  
  @override
  List<Object> get props => [query];
}

/// Event to clear search results
class ClearSearch extends SearchEvent {
  const ClearSearch();
}