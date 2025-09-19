import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../domain/entities/manga.dart';
import '../repositories/home_repository.dart';

/// Use case for getting top manga
class GetTopManga implements UseCase<List<Manga>, NoParams> {
  /// Home repository for data operations
  final HomeRepository repository;
  
  /// Creates a [GetTopManga]
  const GetTopManga(this.repository);
  
  @override
  Future<Either<Failure, List<Manga>>> call(NoParams params) async {
    return await repository.getTopManga();
  }
}