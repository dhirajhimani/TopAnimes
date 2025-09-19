import 'package:equatable/equatable.dart';
import '../../../../domain/entities/anime.dart';
import '../../../../domain/entities/manga.dart';

/// Base class for all home states
abstract class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

/// Initial state when the home screen is first loaded
class HomeInitial extends HomeState {
  const HomeInitial();
}

/// State when home data is being loaded
class HomeLoading extends HomeState {
  const HomeLoading();
}

/// State when home data has been successfully loaded
class HomeLoaded extends HomeState {
  /// List of top airing anime
  final List<Anime> topAiringAnime;
  
  /// List of top manga
  final List<Manga> topManga;
  
  /// Creates a [HomeLoaded] state
  const HomeLoaded({
    required this.topAiringAnime,
    required this.topManga,
  });
  
  @override
  List<Object> get props => [topAiringAnime, topManga];
}

/// State when an error occurred while loading home data
class HomeError extends HomeState {
  /// Error message describing what went wrong
  final String message;
  
  /// Creates a [HomeError] state
  const HomeError(this.message);
  
  @override
  List<Object> get props => [message];
}