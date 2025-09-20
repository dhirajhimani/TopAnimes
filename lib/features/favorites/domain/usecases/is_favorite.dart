import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/favorites_repository.dart';

/// Use case for checking if content is in favorites
class IsFavorite implements UseCase<bool, IsFavoriteParams> {
  /// Favorites repository for data operations
  final FavoritesRepository repository;
  
  /// Creates an [IsFavorite]
  const IsFavorite(this.repository);
  
  @override
  Future<Either<Failure, bool>> call(IsFavoriteParams params) async {
    return await repository.isFavorite(params.contentId);
  }
}

/// Parameters for [IsFavorite] use case
class IsFavoriteParams {
  /// ID of content to check
  final int contentId;
  
  /// Creates [IsFavoriteParams]
  const IsFavoriteParams(this.contentId);
}