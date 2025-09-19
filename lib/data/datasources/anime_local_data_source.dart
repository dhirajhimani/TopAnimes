import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/storage_keys.dart';
import '../../core/error/exceptions.dart';
import '../models/anime_model.dart';

/// Contract for local anime data operations
abstract class AnimeLocalDataSource {
  /// Caches the anime list locally
  Future<void> cacheAnimeList(List<AnimeModel> animeList);
  
  /// Gets the cached anime list
  Future<List<AnimeModel>> getCachedAnimeList();
  
  /// Checks if cache is valid (not expired)
  Future<bool> isCacheValid();
}

/// Implementation of [AnimeLocalDataSource] using SharedPreferences
class AnimeLocalDataSourceImpl implements AnimeLocalDataSource {
  /// Shared preferences instance
  final SharedPreferences sharedPreferences;
  
  /// Creates an [AnimeLocalDataSourceImpl]
  const AnimeLocalDataSourceImpl({required this.sharedPreferences});
  
  @override
  Future<void> cacheAnimeList(List<AnimeModel> animeList) async {
    try {
      final jsonString = jsonEncode(
        animeList.map((anime) => anime.toJson()).toList(),
      );
      
      await Future.wait([
        sharedPreferences.setString(StorageKeys.animeListKey, jsonString),
        sharedPreferences.setInt(
          StorageKeys.lastUpdateKey,
          DateTime.now().millisecondsSinceEpoch,
        ),
      ]);
    } catch (e) {
      throw CacheException('Failed to cache anime list: ${e.toString()}');
    }
  }
  
  @override
  Future<List<AnimeModel>> getCachedAnimeList() async {
    try {
      final jsonString = sharedPreferences.getString(StorageKeys.animeListKey);
      
      if (jsonString == null) {
        throw const CacheException('No cached anime list found');
      }
      
      final jsonList = jsonDecode(jsonString) as List<dynamic>;
      return jsonList
          .map((json) => AnimeModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      if (e is CacheException) {
        rethrow;
      }
      throw CacheException('Failed to get cached anime list: ${e.toString()}');
    }
  }
  
  @override
  Future<bool> isCacheValid() async {
    try {
      final lastUpdate = sharedPreferences.getInt(StorageKeys.lastUpdateKey);
      
      if (lastUpdate == null) {
        return false;
      }
      
      final cacheTime = DateTime.fromMillisecondsSinceEpoch(lastUpdate);
      final now = DateTime.now();
      final difference = now.difference(cacheTime);
      
      return difference.inHours < StorageKeys.cacheHours;
    } catch (e) {
      return false;
    }
  }
}