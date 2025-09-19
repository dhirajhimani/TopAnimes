import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:top_anime/core/usecases/usecase.dart';
import 'package:top_anime/domain/entities/anime.dart';
import 'package:top_anime/domain/repositories/anime_repository.dart';
import 'package:top_anime/domain/usecases/get_top_anime.dart';

class MockAnimeRepository extends Mock implements AnimeRepository {}

void main() {
  late GetTopAnime usecase;
  late MockAnimeRepository mockAnimeRepository;

  setUp(() {
    mockAnimeRepository = MockAnimeRepository();
    usecase = GetTopAnime(mockAnimeRepository);
  });

  const tAnimeList = [
    Anime(
      rank: 1,
      title: 'Test Anime',
      url: 'https://test.com',
      imageUrl: 'https://test.com/image.jpg',
      members: 1000,
    ),
  ];

  test('should get anime list from the repository', () async {
    // arrange
    when(() => mockAnimeRepository.getTopAnime())
        .thenAnswer((_) async => const Right(tAnimeList));

    // act
    final result = await usecase(NoParams());

    // assert
    expect(result, const Right(tAnimeList));
    verify(() => mockAnimeRepository.getTopAnime());
    verifyNoMoreInteractions(mockAnimeRepository);
  });
}