import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/anime.dart';
import '../repositories/anime_repository.dart';

/// Use case for getting the list of top anime
class GetTopAnime implements UseCase<List<Anime>, NoParams> {
  /// Repository for anime data
  final AnimeRepository repository;
  
  /// Creates a [GetTopAnime] use case
  const GetTopAnime(this.repository);
  
  @override
  Future<Either<Failure, List<Anime>>> call(NoParams params) async {
    return repository.getTopAnime();
  }
}