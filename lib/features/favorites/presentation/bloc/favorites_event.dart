import 'package:equatable/equatable.dart';
import '../../domain/entities/favorite_content.dart';
import '../../../../domain/entities/content.dart';

/// Base class for favorites events
abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();
  
  @override
  List<Object?> get props => [];
}

/// Event to load all favorites
class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}

/// Event to add content to favorites
class AddToFavoritesEvent extends FavoritesEvent {
  /// Content to add
  final Content content;
  
  const AddToFavoritesEvent(this.content);
  
  @override
  List<Object?> get props => [content];
}

/// Event to remove content from favorites
class RemoveFromFavoritesEvent extends FavoritesEvent {
  /// ID of content to remove
  final int contentId;
  
  const RemoveFromFavoritesEvent(this.contentId);
  
  @override
  List<Object?> get props => [contentId];
}

/// Event to check if content is favorite
class CheckIsFavorite extends FavoritesEvent {
  /// ID of content to check
  final int contentId;
  
  const CheckIsFavorite(this.contentId);
  
  @override
  List<Object?> get props => [contentId];
}

/// Event to clear all favorites
class ClearAllFavorites extends FavoritesEvent {
  const ClearAllFavorites();
}