import 'package:hive_flutter/hive_flutter.dart';
import '../../domain/entities/favorite_content.dart';

/// Local data source for favorites using Hive
abstract class FavoritesLocalDataSource {
  /// Adds content to favorites
  Future<void> addToFavorites(FavoriteContent content);
  
  /// Removes content from favorites
  Future<void> removeFromFavorites(int contentId);
  
  /// Gets all favorite contents
  Future<List<FavoriteContent>> getFavorites();
  
  /// Checks if content is in favorites
  Future<bool> isFavorite(int contentId);
  
  /// Clears all favorites
  Future<void> clearAllFavorites();
}

/// Implementation of [FavoritesLocalDataSource] using Hive
class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  /// Hive box for storing favorites
  static const String _boxName = 'favorites';
  
  /// Gets the favorites box
  Future<Box<FavoriteContent>> get _box async {
    return Hive.isBoxOpen(_boxName) 
        ? Hive.box<FavoriteContent>(_boxName)
        : await Hive.openBox<FavoriteContent>(_boxName);
  }
  
  @override
  Future<void> addToFavorites(FavoriteContent content) async {
    final box = await _box;
    await box.put(content.id, content);
  }
  
  @override
  Future<void> removeFromFavorites(int contentId) async {
    final box = await _box;
    await box.delete(contentId);
  }
  
  @override
  Future<List<FavoriteContent>> getFavorites() async {
    final box = await _box;
    return box.values.toList()
      ..sort((a, b) => b.addedAt.compareTo(a.addedAt)); // Most recent first
  }
  
  @override
  Future<bool> isFavorite(int contentId) async {
    final box = await _box;
    return box.containsKey(contentId);
  }
  
  @override
  Future<void> clearAllFavorites() async {
    final box = await _box;
    await box.clear();
  }
}