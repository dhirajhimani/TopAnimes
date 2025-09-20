import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/favorites_repository.dart';

/// Use case for removing content from favorites
class RemoveFromFavorites implements UseCase<void, RemoveFromFavoritesParams> {
  /// Favorites repository for data operations
  final FavoritesRepository repository;
  
  /// Creates a [RemoveFromFavorites]
  const RemoveFromFavorites(this.repository);
  
  @override
  Future<Either<Failure, void>> call(RemoveFromFavoritesParams params) async {
    return await repository.removeFromFavorites(params.contentId);
  }
}

/// Parameters for [RemoveFromFavorites] use case
class RemoveFromFavoritesParams {
  /// ID of content to remove from favorites
  final int contentId;
  
  /// Creates [RemoveFromFavoritesParams]
  const RemoveFromFavoritesParams(this.contentId);
}