import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/usecases/usecase.dart';
import '../../domain/usecases/get_top_anime.dart';
import 'anime_state.dart';

/// Cubit for managing anime-related state
class AnimeCubit extends Cubit<AnimeState> {
  /// Use case for getting top anime
  final GetTopAnime getTopAnime;
  
  /// Creates an [AnimeCubit]
  AnimeCubit({required this.getTopAnime}) : super(AnimeInitial());
  
  /// Loads the top anime list
  Future<void> loadTopAnime() async {
    emit(AnimeLoading());
    
    final result = await getTopAnime(NoParams());
    
    result.fold(
      (failure) => emit(AnimeError(failure.message)),
      (animeList) => emit(AnimeLoaded(animeList)),
    );
  }
  
  /// Refreshes the anime list (forces a reload)
  Future<void> refreshAnime() async {
    // Clear cache and reload
    await loadTopAnime();
  }
}