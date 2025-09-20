import 'package:fpdart/fpdart.dart';
import 'package:top_anime/core/error/failures.dart';
import 'package:top_anime/domain/entities/anime.dart';
import 'package:top_anime/domain/entities/manga.dart';

/// Repository contract for home screen data operations
abstract class HomeRepository {
  /// Fetches the list of top airing anime
  /// 
  /// Returns [Right] with list of [Anime] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Anime>>> getTopAiringAnime();
  
  /// Fetches the list of top manga
  /// 
  /// Returns [Right] with list of [Manga] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Manga>>> getTopManga();
}