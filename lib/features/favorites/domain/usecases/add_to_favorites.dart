import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/favorite_content.dart';
import '../repositories/favorites_repository.dart';

/// Use case for adding content to favorites
class AddToFavorites implements UseCase<void, AddToFavoritesParams> {
  /// Favorites repository for data operations
  final FavoritesRepository repository;
  
  /// Creates an [AddToFavorites]
  const AddToFavorites(this.repository);
  
  @override
  Future<Either<Failure, void>> call(AddToFavoritesParams params) async {
    return await repository.addToFavorites(params.content);
  }
}

/// Parameters for [AddToFavorites] use case
class AddToFavoritesParams {
  /// Content to add to favorites
  final FavoriteContent content;
  
  /// Creates [AddToFavoritesParams]
  const AddToFavoritesParams(this.content);
}