import 'package:json_annotation/json_annotation.dart';
import 'manga_model.dart';
import 'top_anime_response.dart'; // For shared PaginationModel

part 'top_manga_response.g.dart';

/// Response model for Jikan API v4 top manga endpoint
@JsonSerializable()
class TopMangaResponse {
  /// List of manga data
  @JsonKey(defaultValue: [])
  final List<MangaModel> data;
  
  /// Pagination information
  // @JsonKey(defaultValue: PaginationModel.empty)
  final PaginationModel pagination;
  
  /// Creates a [TopMangaResponse]
  const TopMangaResponse({
    required this.data,
    required this.pagination,
  });
  
  /// Creates a [TopMangaResponse] from JSON
  factory TopMangaResponse.fromJson(Map<String, dynamic> json) {
    return TopMangaResponse(
      data: (json['data'] as List<dynamic>?)?.map((e) => MangaModel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      pagination: json['pagination'] != null ? PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>) : PaginationModel.empty,
    );
  }

  /// Converts this [TopMangaResponse] to JSON
  Map<String, dynamic> toJson() => _$TopMangaResponseToJson(this);
}