import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/favorite_content.dart';
import '../../domain/repositories/favorites_repository.dart';
import '../datasources/favorites_local_data_source.dart';

/// Implementation of [FavoritesRepository]
class FavoritesRepositoryImpl implements FavoritesRepository {
  /// Local data source for favorites operations
  final FavoritesLocalDataSource localDataSource;
  
  /// Creates a [FavoritesRepositoryImpl]
  const FavoritesRepositoryImpl({
    required this.localDataSource,
  });
  
  @override
  Future<Either<Failure, void>> addToFavorites(FavoriteContent content) async {
    try {
      await localDataSource.addToFavorites(content);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to add to favorites: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, void>> removeFromFavorites(int contentId) async {
    try {
      await localDataSource.removeFromFavorites(contentId);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to remove from favorites: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, List<FavoriteContent>>> getFavorites() async {
    try {
      final favorites = await localDataSource.getFavorites();
      return Right(favorites);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to get favorites: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, bool>> isFavorite(int contentId) async {
    try {
      final isFav = await localDataSource.isFavorite(contentId);
      return Right(isFav);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to check favorite status: ${e.toString()}'));
    }
  }
  
  @override
  Future<Either<Failure, void>> clearAllFavorites() async {
    try {
      await localDataSource.clearAllFavorites();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    } catch (e) {
      return Left(CacheFailure('Failed to clear favorites: ${e.toString()}'));
    }
  }
}