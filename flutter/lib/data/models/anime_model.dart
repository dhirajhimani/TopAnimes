import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/anime.dart';

part 'anime_model.g.dart';

/// Data Transfer Object for Anime
@JsonSerializable()
class AnimeModel {
  /// Rank of the anime
  final int rank;
  
  /// Title of the anime
  final String title;
  
  /// Web URL of the anime
  final String url;
  
  /// Image URL of the anime
  @JsonKey(name: 'image_url')
  final String imageUrl;
  
  /// Number of members who have this anime in their list
  final int members;
  
  /// Creates an [AnimeModel]
  const AnimeModel({
    required this.rank,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.members,
  });
  
  /// Creates an [AnimeModel] from JSON
  factory AnimeModel.fromJson(Map<String, dynamic> json) => 
      _$AnimeModelFromJson(json);
  
  /// Converts this [AnimeModel] to JSON
  Map<String, dynamic> toJson() => _$AnimeModelToJson(this);
  
  /// Converts this [AnimeModel] to a domain [Anime] entity
  Anime toEntity() {
    return Anime(
      rank: rank,
      title: title,
      url: url,
      imageUrl: imageUrl,
      members: members,
    );
  }
  
  /// Creates an [AnimeModel] from a domain [Anime] entity
  factory AnimeModel.fromEntity(Anime anime) {
    return AnimeModel(
      rank: anime.rank,
      title: anime.title,
      url: anime.url,
      imageUrl: anime.imageUrl,
      members: anime.members,
    );
  }
}