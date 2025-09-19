import 'package:json_annotation/json_annotation.dart';
import 'manga_model.dart';
import 'top_anime_response.dart'; // For shared PaginationModel

part 'top_manga_response.g.dart';

/// Response model for Jikan API v4 top manga endpoint
@JsonSerializable()
class TopMangaResponse {
  /// List of manga data
  final List<MangaModel> data;
  
  /// Pagination information
  final PaginationModel pagination;
  
  /// Creates a [TopMangaResponse]
  const TopMangaResponse({
    required this.data,
    required this.pagination,
  });
  
  /// Creates a [TopMangaResponse] from JSON
  factory TopMangaResponse.fromJson(Map<String, dynamic> json) => 
      _$TopMangaResponseFromJson(json);
  
  /// Converts this [TopMangaResponse] to JSON
  Map<String, dynamic> toJson() => _$TopMangaResponseToJson(this);
}