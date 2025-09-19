import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/config/app_config.dart';
import '../../data/repositories/home_repository.dart';
import '../../domain/entities/anime.dart';
import '../../domain/entities/manga.dart';

/// State for home screen
abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

/// Initial state
class HomeInitial extends HomeState {}

/// Loading state
class HomeLoading extends HomeState {}

/// Loaded state with data
class HomeLoaded extends HomeState {
  /// Top airing anime list
  final List<Anime> topAiringAnime;
  
  /// Top manga list
  final List<Manga> topManga;
  
  /// Whether using mock data
  final bool usingMockData;
  
  /// Creates a [HomeLoaded] state
  HomeLoaded({
    required this.topAiringAnime,
    required this.topManga,
    required this.usingMockData,
  });
  
  @override
  List<Object> get props => [topAiringAnime, topManga, usingMockData];
}

/// Error state
class HomeError extends HomeState {
  /// Error message
  final String message;
  
  /// Creates a [HomeError] state
  HomeError(this.message);
  
  @override
  List<Object> get props => [message];
}

/// Cubit for managing home screen state
class HomeCubit extends Cubit<HomeState> {
  /// Repository for home data
  final HomeRepository _repository;
  
  /// Creates a [HomeCubit]
  HomeCubit({
    required HomeRepository repository,
  }) : _repository = repository,
        super(HomeInitial());
  
  /// Loads home screen data
  Future<void> loadHomeData() async {
    emit(HomeLoading());
    
    if (AppConfig.isDebug) {
      // ignore: avoid_print
      print('🏠 Loading home data... Mock: ${AppConfig.useMockData}');
    }
    
    // Load both anime and manga concurrently
    final results = await Future.wait([
      _repository.getTopAiringAnime(),
      _repository.getTopManga(),
    ]);
    
    final animeResult = results[0];
    final mangaResult = results[1];
    
    // Check if both requests succeeded
    if (animeResult.isRight() && mangaResult.isRight()) {
      final animeList = animeResult.getRight().getOrElse(() => <Anime>[]);
      final mangaList = mangaResult.getRight().getOrElse(() => <Manga>[]);
      
      emit(HomeLoaded(
        topAiringAnime: animeList,
        topManga: mangaList,
        usingMockData: AppConfig.useMockData,
      ));
    } else {
      // Handle failure - prioritize anime failure if both fail
      final failure = animeResult.isLeft() 
          ? animeResult.getLeft().getOrElse(() => throw Exception())
          : mangaResult.getLeft().getOrElse(() => throw Exception());
      
      emit(HomeError(failure.message));
    }
  }
  
  /// Refreshes home screen data
  Future<void> refreshHomeData() async {
    await loadHomeData();
  }
  
  /// Toggles mock data and reloads
  Future<void> toggleMockData() async {
    AppConfig.toggleMockData();
    if (AppConfig.isDebug) {
      // ignore: avoid_print
      print('🎭 Mock data toggled: ${AppConfig.useMockData}');
    }
    await loadHomeData();
  }
}