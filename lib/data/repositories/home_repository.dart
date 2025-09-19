import 'package:fpdart/fpdart.dart';

import '../../core/error/failures.dart';
import '../../domain/entities/anime.dart';
import '../../domain/entities/manga.dart';
import '../datasources/home_data_source.dart';

/// Repository for home screen data
class HomeRepository {
  /// Data source for fetching home content
  final HomeDataSource _dataSource;
  
  /// Creates a [HomeRepository]
  const HomeRepository({
    required HomeDataSource dataSource,
  }) : _dataSource = dataSource;
  
  /// Gets top airing anime
  Future<Either<Failure, List<Anime>>> getTopAiringAnime() async {
    return await _dataSource.getTopAiringAnime();
  }
  
  /// Gets top manga
  Future<Either<Failure, List<Manga>>> getTopManga() async {
    return await _dataSource.getTopManga();
  }
}