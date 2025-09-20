import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_anime/core/error/failures.dart';
import 'package:top_anime/domain/entities/anime.dart';
import 'package:top_anime/domain/usecases/get_top_anime.dart';
import 'package:top_anime/features/anime/presentation/bloc/anime_cubit.dart';
import 'package:top_anime/features/anime/presentation/bloc/anime_state.dart';

class MockGetTopAnime extends Mock implements GetTopAnime {}

void main() {
  late AnimeCubit animeCubit;
  late MockGetTopAnime mockGetTopAnime;

  setUp(() {
    mockGetTopAnime = MockGetTopAnime();
    animeCubit = AnimeCubit(getTopAnime: mockGetTopAnime);
  });

  tearDown(() {
    animeCubit.close();
  });

  test('initial state should be AnimeInitial', () {
    expect(animeCubit.state, equals(AnimeInitial()));
  });

  group('loadTopAnime', () {
    const tAnimeList = [
      Anime(
        rank: 1,
        title: 'Test Anime',
        url: 'https://test.com',
        imageUrl: 'https://test.com/image.jpg',
        members: 1000,
        id: 1,
        synopsis: '',
        status: '',
      ),
    ];

    blocTest<AnimeCubit, AnimeState>(
      'should emit [AnimeLoading, AnimeLoaded] when data is gotten successfully',
      build: () {
        when(
          () => mockGetTopAnime(any()),
        ).thenAnswer((_) async => const Right(tAnimeList));
        return animeCubit;
      },
      act: (cubit) => cubit.loadTopAnime(),
      expect: () => [AnimeLoading(), AnimeLoaded(tAnimeList)],
    );

    blocTest<AnimeCubit, AnimeState>(
      'should emit [AnimeLoading, AnimeError] when getting data fails',
      build: () {
        when(
          () => mockGetTopAnime(any()),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return animeCubit;
      },
      act: (cubit) => cubit.loadTopAnime(),
      expect: () => [AnimeLoading(), AnimeError('Server Failure')],
    );
  });

  group('refreshAnime', () {
    const tAnimeList = [
      Anime(
        rank: 1,
        title: 'Test Anime',
        url: 'https://test.com',
        imageUrl: 'https://test.com/image.jpg',
        members: 1000,
        id: 1,
        synopsis: '',
        status: '',
      ),
    ];

    blocTest<AnimeCubit, AnimeState>(
      'should emit [AnimeLoading, AnimeLoaded] when refresh is successful',
      build: () {
        when(
          () => mockGetTopAnime(any()),
        ).thenAnswer((_) async => const Right(tAnimeList));
        return animeCubit;
      },
      act: (cubit) => cubit.refreshAnime(),
      expect: () => [AnimeLoading(), AnimeLoaded(tAnimeList)],
    );
  });
}
