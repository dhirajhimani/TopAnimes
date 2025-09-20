import 'package:fpdart/fpdart.dart';

import '../../core/config/app_config.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_client.dart';
import '../../core/services/mock_data_service.dart';
import '../../domain/entities/anime.dart';
import '../../domain/entities/manga.dart';
import '../models/top_anime_response.dart';
import '../models/top_manga_response.dart';

/// Data source for home screen content
class HomeDataSource {
  /// Network client for API calls
  final NetworkClient _networkClient;
  
  /// Creates a [HomeDataSource]
  const HomeDataSource({
    required NetworkClient networkClient,
  }) : _networkClient = networkClient;
  
  /// Fetches top airing anime
  Future<Either<Failure, List<Anime>>> getTopAiringAnime() async {
    try {
      // Use mock data if enabled
      if (AppConfig.useMockData) {
        if (AppConfig.isDebug) {
          // ignore: avoid_print
          print('🎭 Using mock data for top airing anime');
        }
        return Right(MockDataService.mockAnimeList);
      }
      
      // Make real API call
      final url = '${AppConfig.jikanBaseUrl}/top/anime?filter=airing&limit=10';
      final response = await _networkClient.get<Map<String, dynamic>>(url);
      
      if (response.statusCode == 200 && response.data != null) {
        final topAnimeResponse = TopAnimeResponse.fromJson(response.data!);
        final animeList = topAnimeResponse.data.map((model) => model.toEntity()).toList();
        
        if (AppConfig.isDebug) {
          // ignore: avoid_print
          print('✅ Fetched ${animeList.length} top airing anime');
        }
        
        return Right(animeList);
      } else {
        throw ServerException('Failed to fetch top airing anime. Status: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      if (AppConfig.isDebug) {
        // ignore: avoid_print
        print('❌ Error fetching top airing anime: $e');
      }
      return Left(NetworkFailure('Network error: ${e.toString()}'));
    }
  }
  
  /// Fetches top manga
  Future<Either<Failure, List<Manga>>> getTopManga() async {
    try {
      // Use mock data if enabled
      if (AppConfig.useMockData) {
        if (AppConfig.isDebug) {
          // ignore: avoid_print
          print('🎭 Using mock data for top manga');
        }
        return Right(MockDataService.mockMangaList);
      }
      
      // Make real API call
      final url = '${AppConfig.jikanBaseUrl}/top/manga?limit=10';
      final response = await _networkClient.get<Map<String, dynamic>>(url);
      
      if (response.statusCode == 200 && response.data != null) {
        final topMangaResponse = TopMangaResponse.fromJson(response.data!);
        final mangaList = topMangaResponse.data.map((model) => model.toEntity()).toList();
        
        if (AppConfig.isDebug) {
          // ignore: avoid_print
          print('✅ Fetched ${mangaList.length} top manga');
        }
        
        return Right(mangaList);
      } else {
        throw ServerException('Failed to fetch top manga. Status: ${response.statusCode}');
      }
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      if (AppConfig.isDebug) {
        // ignore: avoid_print
        print('❌ Error fetching top manga: $e');
      }
      return Left(NetworkFailure('Network error: ${e.toString()}'));
    }
  }
}