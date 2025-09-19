import 'package:top_anime/data/models/anime_model.dart';
import 'package:top_anime/data/models/manga_model.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/error/exceptions.dart';
import '../../../core/network/network_client.dart';
import '../../../data/models/anime_model.dart';
import '../../../data/models/manga_model.dart';
import '../../../data/models/top_anime_response.dart';
import '../../../data/models/top_manga_response.dart';

/// Contract for remote home data operations
abstract class HomeRemoteDataSource {
  /// Fetches top airing anime from the remote API
  Future<List<AnimeModel>> getTopAiringAnime();
  
  /// Fetches top manga from the remote API
  Future<List<MangaModel>> getTopManga();
}

/// Implementation of [HomeRemoteDataSource] using HTTP requests
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  /// Network client for making HTTP requests
  final NetworkClient networkClient;
  
  /// Creates a [HomeRemoteDataSourceImpl]
  const HomeRemoteDataSourceImpl({required this.networkClient});
  
  @override
  Future<List<AnimeModel>> getTopAiringAnime() async {
    try {
      final response = await networkClient.get<Map<String, dynamic>>(
        '${ApiConstants.jikanBaseUrl}${ApiConstants.topAiringAnimeEndpoint}',
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final topAnimeResponse = TopAnimeResponse.fromJson(response.data!);
        return topAnimeResponse.data;
      } else {
        throw ServerException(
          'Failed to fetch top airing anime. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw NetworkException('Network error occurred: ${e.toString()}');
    }
  }
  
  @override
  Future<List<MangaModel>> getTopManga() async {
    try {
      final response = await networkClient.get<Map<String, dynamic>>(
        '${ApiConstants.jikanBaseUrl}${ApiConstants.topMangaEndpoint}',
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final topMangaResponse = TopMangaResponse.fromJson(response.data!);
        return topMangaResponse.data;
      } else {
        throw ServerException(
          'Failed to fetch top manga. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      throw NetworkException('Network error occurred: ${e.toString()}');
    }
  }
}