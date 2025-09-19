import 'package:fpdart/fpdart.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../domain/repositories/home_repository.dart';
import '../../../domain/entities/anime.dart';
import '../../../domain/entities/manga.dart';
import '../datasources/home_remote_data_source.dart';

/// Implementation of [HomeRepository]
class HomeRepositoryImpl implements HomeRepository {
  /// Remote data source for fetching data from APIs
  final HomeRemoteDataSource remoteDataSource;
  
  /// Creates a [HomeRepositoryImpl]
  const HomeRepositoryImpl({
    required this.remoteDataSource,
  });
  
  @override
  Future<Either<Failure, List<Anime>>> getTopAiringAnime() async {
    try {
      final animeModels = await remoteDataSource.getTopAiringAnime();
      final animeList = animeModels.map((model) => model.toEntity()).toList();
      return Right(animeList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, List<Manga>>> getTopManga() async {
    try {
      final mangaModels = await remoteDataSource.getTopManga();
      final mangaList = mangaModels.map((model) => model.toEntity()).toList();
      return Right(mangaList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }
}