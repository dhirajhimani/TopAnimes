import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/anime.dart';

/// Abstract repository contract for anime data operations
abstract class AnimeRepository {
  /// Fetches the list of top anime
  /// 
  /// Returns [Right] with list of [Anime] on success
  /// Returns [Left] with [Failure] on error
  Future<Either<Failure, List<Anime>>> getTopAnime();
}