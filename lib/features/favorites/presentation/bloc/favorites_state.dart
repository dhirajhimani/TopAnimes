import 'package:equatable/equatable.dart';
import '../../domain/entities/favorite_content.dart';

/// Base class for favorites states
abstract class FavoritesState extends Equatable {
  const FavoritesState();
  
  @override
  List<Object?> get props => [];
}

/// Initial state
class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

/// Loading state
class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

/// State when favorites are loaded successfully
class FavoritesLoaded extends FavoritesState {
  /// List of favorite contents
  final List<FavoriteContent> favorites;
  
  /// Map to quickly check if content is favorite
  final Map<int, bool> favoriteStatus;
  
  const FavoritesLoaded({
    required this.favorites,
    required this.favoriteStatus,
  });
  
  @override
  List<Object?> get props => [favorites, favoriteStatus];
  
  /// Creates a copy with updated data
  FavoritesLoaded copyWith({
    List<FavoriteContent>? favorites,
    Map<int, bool>? favoriteStatus,
  }) {
    return FavoritesLoaded(
      favorites: favorites ?? this.favorites,
      favoriteStatus: favoriteStatus ?? this.favoriteStatus,
    );
  }
}

/// State when an operation is in progress
class FavoritesOperationInProgress extends FavoritesState {
  /// Current favorites list
  final List<FavoriteContent> favorites;
  
  /// Current favorite status map
  final Map<int, bool> favoriteStatus;
  
  /// Type of operation in progress
  final String operation;
  
  const FavoritesOperationInProgress({
    required this.favorites,
    required this.favoriteStatus,
    required this.operation,
  });
  
  @override
  List<Object?> get props => [favorites, favoriteStatus, operation];
}

/// Error state
class FavoritesError extends FavoritesState {
  /// Error message
  final String message;
  
  /// Current favorites list (if available)
  final List<FavoriteContent> favorites;
  
  /// Current favorite status map (if available)
  final Map<int, bool> favoriteStatus;
  
  const FavoritesError({
    required this.message,
    this.favorites = const [],
    this.favoriteStatus = const {},
  });
  
  @override
  List<Object?> get props => [message, favorites, favoriteStatus];
}