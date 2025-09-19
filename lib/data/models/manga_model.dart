import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/manga.dart';
import 'anime_model.dart'; // For shared ImagesModel

part 'manga_model.g.dart';

/// Data Transfer Object for Manga from Jikan API v4
@JsonSerializable()
class MangaModel {
  /// Unique ID of the manga from MyAnimeList
  @JsonKey(name: 'mal_id')
  final int id;
  
  /// Title of the manga
  final String title;
  
  /// Web URL of the manga
  final String url;
  
  /// Images object containing different sizes
  final ImagesModel images;
  
  /// Synopsis of the manga
  final String? synopsis;
  
  /// Score/rating of the manga
  final double? score;
  
  /// Publication status of the manga
  final String status;
  
  /// Number of chapters
  final int? chapters;
  
  /// Number of volumes
  final int? volumes;
  
  /// Number of members who have this manga in their list
  final int members;
  
  /// Creates a [MangaModel]
  const MangaModel({
    required this.id,
    required this.title,
    required this.url,
    required this.images,
    this.synopsis,
    this.score,
    required this.status,
    this.chapters,
    this.volumes,
    required this.members,
  });
  
  /// Creates a [MangaModel] from JSON
  factory MangaModel.fromJson(Map<String, dynamic> json) => 
      _$MangaModelFromJson(json);
  
  /// Converts this [MangaModel] to JSON
  Map<String, dynamic> toJson() => _$MangaModelToJson(this);
  
  /// Converts this [MangaModel] to a domain [Manga] entity
  Manga toEntity() {
    return Manga(
      id: id,
      title: title,
      url: url,
      imageUrl: images.jpg.imageUrl,
      synopsis: synopsis ?? '',
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
      images: ImagesModel.empty(),
      synopsis: manga.synopsis,
      score: manga.score,
      status: manga.status,
      chapters: manga.chapters,
      volumes: manga.volumes,
      members: manga.members,
    );
  }
}