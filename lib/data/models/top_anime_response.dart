import 'package:json_annotation/json_annotation.dart';
import 'anime_model.dart';

part 'top_anime_response.g.dart';

/// Response model for Jikan API v4 top anime endpoint
@JsonSerializable()
class TopAnimeResponse {
  /// List of anime data
  @JsonKey(defaultValue: [])
  final List<AnimeModel> data;
  
  /// Pagination information
  // @JsonKey(defaultValue: PaginationModel.empty)
  final PaginationModel pagination;
  
  /// Creates a [TopAnimeResponse]
  const TopAnimeResponse({
    required this.data,
    required this.pagination,
  });
  
  /// Creates a [TopAnimeResponse] from JSON
  factory TopAnimeResponse.fromJson(Map<String, dynamic> json) {
    return TopAnimeResponse(
      data: (json['data'] as List<dynamic>?)?.map((e) => AnimeModel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      pagination: json['pagination'] != null ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>) : PaginationModel.empty,
    );
  }

  /// Converts this [TopAnimeResponse] to JSON
  Map<String, dynamic> toJson() => _$TopAnimeResponseToJson(this);
}

/// Pagination model for API responses
@JsonSerializable()
class PaginationModel {
  /// Last visible page
  @JsonKey(name: 'last_visible_page', defaultValue: 0)
  final int lastVisiblePage;
  
  /// Whether there are more items
  @JsonKey(name: 'has_next_page', defaultValue: false)
  final bool hasNextPage;
  
  /// Current page
  @JsonKey(name: 'current_page', defaultValue: 0)
  final int currentPage;
  
  /// Items per page
  // @JsonKey(defaultValue: ItemsModel.empty)
  final ItemsModel items;
  
  /// Creates a [PaginationModel]
  const PaginationModel({
    required this.lastVisiblePage,
    required this.hasNextPage,
    required this.currentPage,
    required this.items,
  });
  
  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      lastVisiblePage: json['last_visible_page'] as int? ?? 0,
      hasNextPage: json['has_next_page'] as bool? ?? false,
      currentPage: json['current_page'] as int? ?? 0,
      items: json['items'] != null ? ItemsModel.fromJson(json['items'] as Map<String, dynamic>) : ItemsModel.empty,
    );
  }

  Map<String, dynamic> toJson() => _$PaginationModelToJson(this);

  static const PaginationModel empty = PaginationModel(
    lastVisiblePage: 0,
    hasNextPage: false,
    currentPage: 0,
    items: ItemsModel.empty,
  );
}

/// Items model for pagination details
@JsonSerializable()
class ItemsModel {
  /// Items count
  @JsonKey(defaultValue: 0)
  final int count;
  
  /// Total items
  @JsonKey(defaultValue: 0)
  final int total;
  
  /// Items per page
  @JsonKey(name: 'per_page', defaultValue: 0)
  final int perPage;
  
  /// Creates an [ItemsModel]
  const ItemsModel({
    required this.count,
    required this.total,
    required this.perPage,
  });
  
  factory ItemsModel.fromJson(Map<String, dynamic> json) {
    return ItemsModel(
      count: json['count'] as int? ?? 0,
      total: json['total'] as int? ?? 0,
      perPage: json['per_page'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => _$ItemsModelToJson(this);

  static const ItemsModel empty = ItemsModel(
    count: 0,
    total: 0,
    perPage: 0,
  );
}