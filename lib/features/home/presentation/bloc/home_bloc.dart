import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:top_anime/core/error/failures.dart';
import 'package:top_anime/domain/entities/anime.dart';
import 'package:top_anime/domain/entities/manga.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_top_airing_anime.dart';
import '../../domain/usecases/get_top_manga.dart';
import 'home_event.dart';
import 'home_state.dart';

/// BLoC for managing home screen state
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// Use case for getting top airing anime
  final GetTopAiringAnime getTopAiringAnime;

  /// Use case for getting top manga
  final GetTopManga getTopManga;

  /// Creates a [HomeBloc]
  HomeBloc({required this.getTopAiringAnime, required this.getTopManga})
    : super(const HomeInitial()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<RefreshHomeData>(_onRefreshHomeData);
  }

  /// Handles loading home data
  Future<void> _onLoadHomeData(
    LoadHomeData event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());

    // Load both anime and manga data concurrently
    final results = await Future.wait([
      getTopAiringAnime(NoParams()),
      getTopManga(NoParams()),
    ]);

    final Either<Failure, List<Anime>> animeResult =
        results[0] as Either<Failure, List<Anime>>;
    final Either<Failure, List<Manga>> mangaResult =
        results[1] as Either<Failure, List<Manga>>;

    // Check if both results are successful
    if (animeResult.isRight() && mangaResult.isRight()) {
      final rightAnime = animeResult.getRight();
      final List<Anime> animeList = rightAnime.getOrElse(
        () => <Anime>[],
      );
      final rightManga = mangaResult.getRight();
      final List<Manga> mangaList = rightManga.getOrElse(
        () => <Manga>[],
      );

      emit(
        HomeLoaded(
          topAiringAnime: animeList as List<Anime>,
          topManga: mangaList as List<Manga>,
        ),
      );
    } else {
      // Handle failures - prioritize anime failure if both fail
      final Failure failure = animeResult.isLeft()
          ? animeResult.getLeft().getOrElse(() => throw Exception())
          : mangaResult.getLeft().getOrElse(() => throw Exception());

      emit(HomeError(failure.message));
    }
  }

  /// Handles refreshing home data
  Future<void> _onRefreshHomeData(
    RefreshHomeData event,
    Emitter<HomeState> emit,
  ) async {
    // For refresh, we just trigger the same logic as loading
    await _onLoadHomeData(const LoadHomeData(), emit);
  }
}
