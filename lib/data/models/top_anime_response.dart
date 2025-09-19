import 'package:json_annotation/json_annotation.dart';
import 'anime_model.dart';

part 'top_anime_response.g.dart';

/// Response model for top anime API call
@JsonSerializable()
class TopAnimeResponse {
  /// List of top anime
  final List<AnimeModel> top;
  
  /// Creates a [TopAnimeResponse]
  const TopAnimeResponse({required this.top});
  
  /// Creates a [TopAnimeResponse] from JSON
  factory TopAnimeResponse.fromJson(Map<String, dynamic> json) => 
      _$TopAnimeResponseFromJson(json);
  
  /// Converts this [TopAnimeResponse] to JSON
  Map<String, dynamic> toJson() => _$TopAnimeResponseToJson(this);
}