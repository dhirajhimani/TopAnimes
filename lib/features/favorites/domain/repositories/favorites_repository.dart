import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/favorite_content.dart';

/// Repository contract for favorites data operations
abstract class FavoritesRepository {
  /// Adds content to favorites
  Future<Either<Failure, void>> addToFavorites(FavoriteContent content);
  
  /// Removes content from favorites
  Future<Either<Failure, void>> removeFromFavorites(int contentId);
  
  /// Gets all favorite contents
  Future<Either<Failure, List<FavoriteContent>>> getFavorites();
  
  /// Checks if content is in favorites
  Future<Either<Failure, bool>> isFavorite(int contentId);
  
  /// Clears all favorites
  Future<Either<Failure, void>> clearAllFavorites();
}