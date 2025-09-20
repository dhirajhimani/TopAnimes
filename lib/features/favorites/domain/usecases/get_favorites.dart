import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/favorite_content.dart';
import '../repositories/favorites_repository.dart';

/// Use case for getting all favorite contents
class GetFavorites implements UseCase<List<FavoriteContent>, NoParams> {
  /// Favorites repository for data operations
  final FavoritesRepository repository;
  
  /// Creates a [GetFavorites]
  const GetFavorites(this.repository);
  
  @override
  Future<Either<Failure, List<FavoriteContent>>> call(NoParams params) async {
    return await repository.getFavorites();
  }
}