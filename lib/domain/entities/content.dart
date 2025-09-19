import 'package:equatable/equatable.dart';
import 'anime.dart';
import 'manga.dart';
import 'light_novel.dart';

/// Enum to represent different types of content
enum ContentType { anime, manga, lightNovel }

/// Universal content entity that can represent anime, manga, or light novel
class Content extends Equatable {
  /// Type of content
  final ContentType type;
  
  /// Unique ID of the content
  final int id;
  
  /// Title of the content
  final String title;
  
  /// Web URL of the content
  final String url;
  
  /// Image URL of the content
  final String imageUrl;
  
  /// Synopsis of the content
  final String synopsis;
  
  /// Score/rating of the content
  final double? score;
  
  /// Status of the content
  final String status;
  
  /// Number of members/followers
  final int members;
  
  /// Additional metadata specific to content type
  final Map<String, dynamic> metadata;
  
  /// Creates a [Content] entity
  const Content({
    required this.type,
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.synopsis,
    this.score,
    required this.status,
    required this.members,
    this.metadata = const {},
  });
  
  /// Creates a [Content] from an [Anime] entity
  factory Content.fromAnime(Anime anime) {
    return Content(
      type: ContentType.anime,
      id: anime.id,
      title: anime.title,
      url: anime.url,
      imageUrl: anime.imageUrl,
      synopsis: anime.synopsis,
      score: anime.score,
      status: anime.status,
      members: anime.members,
      metadata: {
        'rank': anime.rank,
        'episodes': anime.episodes,
        'season': anime.season,
        'broadcast': anime.broadcast,
      },
    );
  }
  
  /// Creates a [Content] from a [Manga] entity
  factory Content.fromManga(Manga manga) {
    return Content(
      type: ContentType.manga,
      id: manga.id,
      title: manga.title,
      url: manga.url,
      imageUrl: manga.imageUrl,
      synopsis: manga.synopsis,
      score: manga.score,
      status: manga.status,
      members: manga.members,
      metadata: {
        'chapters': manga.chapters,
        'volumes': manga.volumes,
      },
    );
  }
  
  /// Creates a [Content] from a [LightNovel] entity
  factory Content.fromLightNovel(LightNovel lightNovel) {
    return Content(
      type: ContentType.lightNovel,
      id: lightNovel.id,
      title: lightNovel.title,
      url: lightNovel.url,
      imageUrl: lightNovel.imageUrl,
      synopsis: lightNovel.synopsis,
      score: null, // Light novels from RanobeDB don't have scores
      status: lightNovel.status,
      members: 0, // Light novels don't have member counts in RanobeDB
      metadata: {
        'year': lightNovel.year,
        'volumes': lightNovel.volumes,
        'authors': lightNovel.authors,
        'language': lightNovel.language,
      },
    );
  }
  
  @override
  List<Object?> get props => [
    type, id, title, url, imageUrl, synopsis, 
    score, status, members, metadata
  ];
  
  @override
  String toString() {
    return 'Content(type: $type, id: $id, title: $title, url: $url, '
           'imageUrl: $imageUrl, synopsis: $synopsis, score: $score, '
           'status: $status, members: $members, metadata: $metadata)';
  }
}