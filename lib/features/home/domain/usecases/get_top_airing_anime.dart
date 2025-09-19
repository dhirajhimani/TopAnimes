import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/anime.dart';
import '../repositories/home_repository.dart';

/// Use case for getting top airing anime
class GetTopAiringAnime implements UseCase<List<Anime>, NoParams> {
  /// Home repository for data operations
  final HomeRepository repository;
  
  /// Creates a [GetTopAiringAnime]
  const GetTopAiringAnime(this.repository);
  
  @override
  Future<Either<Failure, List<Anime>>> call(NoParams params) async {
    return await repository.getTopAiringAnime();
  }
}