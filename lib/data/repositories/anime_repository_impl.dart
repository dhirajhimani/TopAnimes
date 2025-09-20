import 'package:fpdart/fpdart.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/anime.dart';
import '../../domain/repositories/anime_repository.dart';
import '../datasources/anime_local_data_source.dart';
import '../datasources/anime_remote_data_source.dart';

/// Implementation of [AnimeRepository]
class AnimeRepositoryImpl implements AnimeRepository {
  /// Remote data source for anime
  final AnimeRemoteDataSource remoteDataSource;
  
  /// Local data source for anime
  final AnimeLocalDataSource localDataSource;
  
  /// Creates an [AnimeRepositoryImpl]
  const AnimeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });
  
  @override
  Future<Either<Failure, List<Anime>>> getTopAnime() async {
    try {
      // Check if cache is valid first
      final isCacheValid = await localDataSource.isCacheValid();
      
      if (isCacheValid) {
        try {
          final cachedAnime = await localDataSource.getCachedAnimeList();
          return Right(cachedAnime.map((model) => model.toEntity()).toList());
        } on CacheException {
          // If cache fails, continue to fetch from remote
        }
      }
      
      // Fetch from remote if cache is invalid or failed
      try {
        final remoteAnime = await remoteDataSource.getTopAnime();
        
        // Cache the result for future use
        await localDataSource.cacheAnimeList(remoteAnime);
        
        return Right(remoteAnime.map((model) => model.toEntity()).toList());
      } on ServerException catch (e) {
        // If remote fails, try to return cached data as fallback
        try {
          final cachedAnime = await localDataSource.getCachedAnimeList();
          return Right(cachedAnime.map((model) => model.toEntity()).toList());
        } on CacheException {
          return Left(ServerFailure(e.message));
        }
      } on NetworkException catch (e) {
        // If network fails, try to return cached data as fallback
        try {
          final cachedAnime = await localDataSource.getCachedAnimeList();
          return Right(cachedAnime.map((model) => model.toEntity()).toList());
        } on CacheException {
          return Left(NetworkFailure(e.message));
        }
      }
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error occurred: ${e.toString()}'));
    }
  }
}