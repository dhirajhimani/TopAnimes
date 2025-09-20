import 'package:equatable/equatable.dart';
import 'package:top_anime/domain/entities/anime.dart';

/// Base state for anime-related UI states
abstract class AnimeState extends Equatable {
  @override
  List<Object> get props => [];
}

/// Initial state when the page is first loaded
class AnimeInitial extends AnimeState {}

/// State when anime data is being loaded
class AnimeLoading extends AnimeState {}

/// State when anime data has been successfully loaded
class AnimeLoaded extends AnimeState {
  /// List of anime that was loaded
  final List<Anime> animeList;
  
  /// Creates an [AnimeLoaded] state
  AnimeLoaded(this.animeList);
  
  @override
  List<Object> get props => [animeList];
}

/// State when an error occurred while loading anime data
class AnimeError extends AnimeState {
  /// Error message describing what went wrong
  final String message;
  
  /// Creates an [AnimeError] state
  AnimeError(this.message);
  
  @override
  List<Object> get props => [message];
}