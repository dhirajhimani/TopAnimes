import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/manga.dart';
import 'anime_model.dart'; // For shared ImagesModel

part 'manga_model.g.dart';

/// Data Transfer Object for Manga from Jikan API v4
@JsonSerializable()
class MangaModel {
  /// Unique ID of the manga from MyAnimeList
  @JsonKey(name: 'mal_id', defaultValue: 0)
  final int id;
  
  /// Title of the manga
  @JsonKey(defaultValue: '')
  final String title;
  
  /// Web URL of the manga
  @JsonKey(defaultValue: '')
  final String url;
  
  /// Images object containing different sizes
  // @JsonKey(defaultValue: ImagesModel.empty)
  final ImagesModel images;
  
  /// Synopsis of the manga
  @JsonKey(defaultValue: '')
  final String synopsis;

  /// Score/rating of the manga
  @JsonKey(defaultValue: 0.0)
  final double score;

  /// Publication status of the manga
  @JsonKey(defaultValue: '')
  final String status;
  
  /// Number of chapters
  @JsonKey(defaultValue: 0)
  final int chapters;

  /// Number of volumes
  @JsonKey(defaultValue: 0)
  final int volumes;

  /// Number of members who have this manga in their list
  @JsonKey(defaultValue: 0)
  final int members;
  
  /// Creates a [MangaModel]
  const MangaModel({
    required this.id,
    required this.title,
    required this.url,
    required this.images,
    required this.synopsis,
    required this.score,
    required this.status,
    required this.chapters,
    required this.volumes,
    required this.members,
  });
  
  /// Creates a [MangaModel] from JSON
  factory MangaModel.fromJson(Map<String, dynamic> json) {
    return MangaModel(
      id: json['mal_id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      url: json['url'] as String? ?? '',
      images: json['images'] != null ? ImagesModel.fromJson(json['images'] as Map<String, dynamic>) : ImagesModel.empty,
      synopsis: json['synopsis'] as String? ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? '',
      chapters: json['chapters'] as int? ?? 0,
      volumes: json['volumes'] as int? ?? 0,
      members: json['members'] as int? ?? 0,
    );
  }

  /// Converts this [MangaModel] to JSON
  Map<String, dynamic> toJson() => _$MangaModelToJson(this);
  
  /// Converts this [MangaModel] to a domain [Manga] entity
  Manga toEntity() {
    return Manga(
      id: id,
      title: title,
      url: url,
      imageUrl: images.jpg.imageUrl,
      synopsis: synopsis,
      score: score,
      status: status,
      chapters: chapters,
      volumes: volumes,
      members: members,
    );
  }
  
  /// Creates a [MangaModel] from a domain [Manga] entity
  factory MangaModel.fromEntity(Manga manga) {
    return MangaModel(
      id: manga.id,
      title: manga.title,
      url: manga.url,
      images: ImagesModel.empty,
      synopsis: manga.synopsis,
      score: manga.score ?? 0.0,
      status: manga.status,
      chapters: manga.chapters ?? 0,
      volumes: manga.volumes ?? 0,
      members: manga.members,
    );
  }
}