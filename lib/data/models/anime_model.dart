import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/anime.dart';

part 'anime_model.g.dart';

/// Data Transfer Object for Anime from Jikan API v4
@JsonSerializable()
class AnimeModel {
  /// Unique ID of the anime from MyAnimeList
  @JsonKey(name: 'mal_id')
  final int id;
  
  /// Rank of the anime (if available)
  final int? rank;
  
  /// Title of the anime
  final String title;
  
  /// Web URL of the anime
  final String url;
  
  /// Images object containing different sizes
  final ImagesModel images;
  
  /// Synopsis of the anime
  final String? synopsis;
  
  /// Score/rating of the anime
  final double? score;
  
  /// Airing status of the anime
  final String status;
  
  /// Number of episodes
  final int? episodes;
  
  /// Season information
  final String? season;
  
  /// Year of airing
  final int? year;
  
  /// Broadcast information
  final BroadcastModel? broadcast;
  
  /// Number of members who have this anime in their list
  final int members;
  
  /// Creates an [AnimeModel]
  const AnimeModel({
    required this.id,
    this.rank,
    required this.title,
    required this.url,
    required this.images,
    this.synopsis,
    this.score,
    required this.status,
    this.episodes,
    this.season,
    this.year,
    this.broadcast,
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
      id: id,
      rank: rank,
      title: title,
      url: url,
      imageUrl: images.jpg.imageUrl,
      synopsis: synopsis ?? '',
      score: score,
      status: status,
      episodes: episodes,
      season: season != null && year != null ? '$season $year' : null,
      broadcast: broadcast?.string,
      members: members,
    );
  }
  
  /// Creates an [AnimeModel] from a domain [Anime] entity
  factory AnimeModel.fromEntity(Anime anime) {
    return AnimeModel(
      id: anime.id,
      rank: anime.rank,
      title: anime.title,
      url: anime.url,
      images: ImagesModel.empty(),
      synopsis: anime.synopsis,
      score: anime.score,
      status: anime.status,
      episodes: anime.episodes,
      season: anime.season?.split(' ').first,
      year: anime.season != null ? int.tryParse(anime.season!.split(' ').last) : null,
      broadcast: anime.broadcast != null ? BroadcastModel(string: anime.broadcast!) : null,
      members: anime.members,
    );
  }
}

/// Images model for anime/manga images
@JsonSerializable()
class ImagesModel {
  /// JPG images
  final JpgImagesModel jpg;
  
  /// WebP images
  final WebpImagesModel? webp;
  
  const ImagesModel({
    required this.jpg,
    this.webp,
  });
  
  factory ImagesModel.fromJson(Map<String, dynamic> json) => 
      _$ImagesModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$ImagesModelToJson(this);
  
  factory ImagesModel.empty() => const ImagesModel(
    jpg: JpgImagesModel(imageUrl: '', smallImageUrl: '', largeImageUrl: ''),
  );
}

/// JPG images model
@JsonSerializable()
class JpgImagesModel {
  /// Default image URL
  @JsonKey(name: 'image_url')
  final String imageUrl;
  
  /// Small image URL
  @JsonKey(name: 'small_image_url')
  final String smallImageUrl;
  
  /// Large image URL
  @JsonKey(name: 'large_image_url')
  final String largeImageUrl;
  
  const JpgImagesModel({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });
  
  factory JpgImagesModel.fromJson(Map<String, dynamic> json) => 
      _$JpgImagesModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$JpgImagesModelToJson(this);
}

/// WebP images model
@JsonSerializable()
class WebpImagesModel {
  /// Default image URL
  @JsonKey(name: 'image_url')
  final String imageUrl;
  
  /// Small image URL
  @JsonKey(name: 'small_image_url')
  final String smallImageUrl;
  
  /// Large image URL
  @JsonKey(name: 'large_image_url')
  final String largeImageUrl;
  
  const WebpImagesModel({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });
  
  factory WebpImagesModel.fromJson(Map<String, dynamic> json) => 
      _$WebpImagesModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$WebpImagesModelToJson(this);
}

/// Broadcast model for anime broadcast information
@JsonSerializable()
class BroadcastModel {
  /// Broadcast day
  final String? day;
  
  /// Broadcast time
  final String? time;
  
  /// Timezone
  final String? timezone;
  
  /// Full broadcast string
  final String string;
  
  const BroadcastModel({
    this.day,
    this.time,
    this.timezone,
    required this.string,
  });
  
  factory BroadcastModel.fromJson(Map<String, dynamic> json) => 
      _$BroadcastModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$BroadcastModelToJson(this);
}