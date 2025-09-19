import 'package:json_annotation/json_annotation.dart';
import 'anime_model.dart';

part 'top_anime_response.g.dart';

/// Response model for Jikan API v4 top anime endpoint
@JsonSerializable()
class TopAnimeResponse {
  /// List of anime data
  final List<AnimeModel> data;
  
  /// Pagination information
  final PaginationModel pagination;
  
  /// Creates a [TopAnimeResponse]
  const TopAnimeResponse({
    required this.data,
    required this.pagination,
  });
  
  /// Creates a [TopAnimeResponse] from JSON
  factory TopAnimeResponse.fromJson(Map<String, dynamic> json) => 
      _$TopAnimeResponseFromJson(json);
  
  /// Converts this [TopAnimeResponse] to JSON
  Map<String, dynamic> toJson() => _$TopAnimeResponseToJson(this);
}

/// Pagination model for API responses
@JsonSerializable()
class PaginationModel {
  /// Last visible page
  @JsonKey(name: 'last_visible_page')
  final int lastVisiblePage;
  
  /// Whether there are more items
  @JsonKey(name: 'has_next_page')
  final bool hasNextPage;
  
  /// Current page
  @JsonKey(name: 'current_page')
  final int currentPage;
  
  /// Items per page
  final ItemsModel items;
  
  /// Creates a [PaginationModel]
  const PaginationModel({
    required this.lastVisiblePage,
    required this.hasNextPage,
    required this.currentPage,
    required this.items,
  });
  
  factory PaginationModel.fromJson(Map<String, dynamic> json) => 
      _$PaginationModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);
}

/// Items model for pagination details
@JsonSerializable()
class ItemsModel {
  /// Items count
  final int count;
  
  /// Total items
  final int total;
  
  /// Items per page
  @JsonKey(name: 'per_page')
  final int perPage;
  
  /// Creates an [ItemsModel]
  const ItemsModel({
    required this.count,
    required this.total,
    required this.perPage,
  });
  
  factory ItemsModel.fromJson(Map<String, dynamic> json) => 
      _$ItemsModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$ItemsModelToJson(this);
}