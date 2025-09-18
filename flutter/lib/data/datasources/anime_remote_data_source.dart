import '../../core/constants/api_constants.dart';
import '../../core/error/exceptions.dart';
import '../../core/network/network_client.dart';
import '../models/anime_model.dart';
import '../models/top_anime_response.dart';

/// Contract for remote anime data operations
abstract class AnimeRemoteDataSource {
  /// Fetches top anime from the remote API
  Future<List<AnimeModel>> getTopAnime();
}

/// Implementation of [AnimeRemoteDataSource] using HTTP requests
class AnimeRemoteDataSourceImpl implements AnimeRemoteDataSource {
  /// Network client for making HTTP requests
  final NetworkClient networkClient;
  
  /// Creates an [AnimeRemoteDataSourceImpl]
  const AnimeRemoteDataSourceImpl({required this.networkClient});
  
  @override
  Future<List<AnimeModel>> getTopAnime() async {
    try {
      final response = await networkClient.get<Map<String, dynamic>>(
        ApiConstants.topAnimeEndpoint,
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final topAnimeResponse = TopAnimeResponse.fromJson(response.data!);
        return topAnimeResponse.top;
      } else {
        throw ServerException(
          'Failed to fetch anime data. Status: ${response.statusCode}',
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