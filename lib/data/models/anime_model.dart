import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/anime.dart';

part 'anime_model.g.dart';

/// Data Transfer Object for Anime from Jikan API v4
@JsonSerializable()
class AnimeModel {
  /// Unique ID of the anime from MyAnimeList
  @JsonKey(name: 'mal_id', defaultValue: 0)
  final int id;
  
  /// Rank of the anime (if available)
  @JsonKey(defaultValue: 0)
  final int rank;

  /// Title of the anime
  @JsonKey(defaultValue: '')
  final String title;
  
  /// Web URL of the anime
  @JsonKey(defaultValue: '')
  final String url;
  
  /// Images object containing different sizes
  // @JsonKey(defaultValue: ImagesModel.empty)
  final ImagesModel images;
  
  /// Synopsis of the anime
  @JsonKey(defaultValue: '')
  final String synopsis;

  /// Score/rating of the anime
  @JsonKey(defaultValue: 0.0)
  final double score;

  /// Airing status of the anime
  @JsonKey(defaultValue: '')
  final String status;
  
  /// Number of episodes
  @JsonKey(defaultValue: 0)
  final int episodes;

  /// Season information
  @JsonKey(defaultValue: '')
  final String season;

  /// Year of airing
  @JsonKey(defaultValue: 0)
  final int year;

  /// Broadcast information
  // @JsonKey(defaultValue: BroadcastModel.empty)
  final BroadcastModel broadcast;

  /// Number of members who have this anime in their list
  @JsonKey(defaultValue: 0)
  final int members;
  
  /// Creates an [AnimeModel]
  const AnimeModel({
    required this.id,
    required this.rank,
    required this.title,
    required this.url,
    required this.images,
    required this.synopsis,
    required this.score,
    required this.status,
    required this.episodes,
    required this.season,
    required this.year,
    required this.broadcast,
    required this.members,
  });
  
  /// Creates an [AnimeModel] from JSON
  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      id: json['mal_id'] as int? ?? 0,
      rank: json['rank'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      url: json['url'] as String? ?? '',
      images: json['images'] != null ? ImagesModel.fromJson(json['images'] as Map<String, dynamic>) : ImagesModel.empty,
      synopsis: json['synopsis'] as String? ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? '',
      episodes: json['episodes'] as int? ?? 0,
      season: json['season'] as String? ?? '',
      year: json['year'] as int? ?? 0,
      broadcast: json['broadcast'] != null ? BroadcastModel.fromJson(json['broadcast'] as Map<String, dynamic>) : BroadcastModel.empty,
      members: json['members'] as int? ?? 0,
    );
  }

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
      synopsis: synopsis,
      score: score,
      status: status,
      episodes: episodes,
      season: season.isNotEmpty && year != 0 ? '$season $year' : '',
      broadcast: broadcast.string,
      members: members,
    );
  }
  
  /// Creates an [AnimeModel] from a domain [Anime] entity
  factory AnimeModel.fromEntity(Anime anime) {
    return AnimeModel(
      id: anime.id,
      rank: anime.rank ?? 0,
      title: anime.title,
      url: anime.url,
      images: ImagesModel.empty,
      synopsis: anime.synopsis,
      score: anime.score ?? 0.0,
      status: anime.status,
      episodes: anime.episodes ?? 0,
      season: anime.season?.split(' ').first ?? '',
      year: anime.season != null ? int.tryParse(anime.season!.split(' ').last) ?? 0 : 0,
      broadcast: anime.broadcast != null ? BroadcastModel(string: anime.broadcast!, day: '', time: '', timezone: '') : BroadcastModel.empty,
      members: anime.members,
    );
  }
}

/// Images model for anime/manga images
@JsonSerializable()
class ImagesModel {
  /// JPG images
  // @JsonKey(defaultValue: JpgImagesModel.empty)
  final JpgImagesModel jpg;
  
  /// WebP images
  // @JsonKey(defaultValue: WebpImagesModel.empty)
  final WebpImagesModel webp;

  const ImagesModel({
    required this.jpg,
    required this.webp,
  });
  
  factory ImagesModel.fromJson(Map<String, dynamic> json) => 
      ImagesModel(
        jpg: json['jpg'] != null ? JpgImagesModel.fromJson(json['jpg'] as Map<String, dynamic>) : JpgImagesModel.empty,
        webp: json['webp'] != null ? WebpImagesModel.fromJson(json['webp'] as Map<String, dynamic>) : WebpImagesModel.empty,
      );

  Map<String, dynamic> toJson() => _$ImagesModelToJson(this);
  
  static const ImagesModel empty = ImagesModel(
    jpg: JpgImagesModel.empty,
    webp: WebpImagesModel.empty,
  );
}

/// JPG images model
@JsonSerializable()
class JpgImagesModel {
  /// Default image URL
  @JsonKey(name: 'image_url', defaultValue: '')
  final String imageUrl;
  
  /// Small image URL
  @JsonKey(name: 'small_image_url', defaultValue: '')
  final String smallImageUrl;
  
  /// Large image URL
  @JsonKey(name: 'large_image_url', defaultValue: '')
  final String largeImageUrl;
  
  const JpgImagesModel({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });
  
  factory JpgImagesModel.fromJson(Map<String, dynamic> json) => JpgImagesModel(
    imageUrl: json['image_url'] as String? ?? '',
    smallImageUrl: json['small_image_url'] as String? ?? '',
    largeImageUrl: json['large_image_url'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => _$JpgImagesModelToJson(this);

  static const JpgImagesModel empty = JpgImagesModel(
    imageUrl: '',
    smallImageUrl: '',
    largeImageUrl: '',
  );
}

/// WebP images model
@JsonSerializable()
class WebpImagesModel {
  /// Default image URL
  @JsonKey(name: 'image_url', defaultValue: '')
  final String imageUrl;
  
  /// Small image URL
  @JsonKey(name: 'small_image_url', defaultValue: '')
  final String smallImageUrl;
  
  /// Large image URL
  @JsonKey(name: 'large_image_url', defaultValue: '')
  final String largeImageUrl;
  
  const WebpImagesModel({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });
  
  factory WebpImagesModel.fromJson(Map<String, dynamic> json) => WebpImagesModel(
    imageUrl: json['image_url'] as String? ?? '',
    smallImageUrl: json['small_image_url'] as String? ?? '',
    largeImageUrl: json['large_image_url'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => _$WebpImagesModelToJson(this);

  static const WebpImagesModel empty = WebpImagesModel(
    imageUrl: '',
    smallImageUrl: '',
    largeImageUrl: '',
  );
}

/// Broadcast model for anime broadcast information
@JsonSerializable()
class BroadcastModel {
  /// Broadcast day
  @JsonKey(defaultValue: '')
  final String day;

  /// Broadcast time
  @JsonKey(defaultValue: '')
  final String time;

  /// Timezone
  @JsonKey(defaultValue: '')
  final String timezone;

  /// Full broadcast string
  @JsonKey(defaultValue: '')
  final String string;
  
  const BroadcastModel({
    required this.day,
    required this.time,
    required this.timezone,
    required this.string,
  });
  
  factory BroadcastModel.fromJson(Map<String, dynamic> json) => BroadcastModel(
    day: json['day'] as String? ?? '',
    time: json['time'] as String? ?? '',
    timezone: json['timezone'] as String? ?? '',
    string: json['string'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => _$BroadcastModelToJson(this);

  static const BroadcastModel empty = BroadcastModel(
    day: '',
    time: '',
    timezone: '',
    string: '',
  );
}