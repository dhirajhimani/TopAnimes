// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnimeModel _$AnimeModelFromJson(Map<String, dynamic> json) => AnimeModel(
      id: (json['mal_id'] as num?)?.toInt() ?? 0,
      rank: (json['rank'] as num?)?.toInt() ?? 0,
      title: json['title'] as String? ?? '',
      url: json['url'] as String? ?? '',
      images: ImagesModel.fromJson(json['images'] as Map<String, dynamic>),
      synopsis: json['synopsis'] as String? ?? '',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] as String? ?? '',
      episodes: (json['episodes'] as num?)?.toInt() ?? 0,
      season: json['season'] as String? ?? '',
      year: (json['year'] as num?)?.toInt() ?? 0,
      broadcast:
          BroadcastModel.fromJson(json['broadcast'] as Map<String, dynamic>),
      members: (json['members'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AnimeModelToJson(AnimeModel instance) =>
    <String, dynamic>{
      'mal_id': instance.id,
      'rank': instance.rank,
      'title': instance.title,
      'url': instance.url,
      'images': instance.images,
      'synopsis': instance.synopsis,
      'score': instance.score,
      'status': instance.status,
      'episodes': instance.episodes,
      'season': instance.season,
      'year': instance.year,
      'broadcast': instance.broadcast,
      'members': instance.members,
    };

ImagesModel _$ImagesModelFromJson(Map<String, dynamic> json) => ImagesModel(
      jpg: JpgImagesModel.fromJson(json['jpg'] as Map<String, dynamic>),
      webp: WebpImagesModel.fromJson(json['webp'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ImagesModelToJson(ImagesModel instance) =>
    <String, dynamic>{
      'jpg': instance.jpg,
      'webp': instance.webp,
    };

JpgImagesModel _$JpgImagesModelFromJson(Map<String, dynamic> json) =>
    JpgImagesModel(
      imageUrl: json['image_url'] as String? ?? '',
      smallImageUrl: json['small_image_url'] as String? ?? '',
      largeImageUrl: json['large_image_url'] as String? ?? '',
    );

Map<String, dynamic> _$JpgImagesModelToJson(JpgImagesModel instance) =>
    <String, dynamic>{
      'image_url': instance.imageUrl,
      'small_image_url': instance.smallImageUrl,
      'large_image_url': instance.largeImageUrl,
    };

WebpImagesModel _$WebpImagesModelFromJson(Map<String, dynamic> json) =>
    WebpImagesModel(
      imageUrl: json['image_url'] as String? ?? '',
      smallImageUrl: json['small_image_url'] as String? ?? '',
      largeImageUrl: json['large_image_url'] as String? ?? '',
    );

Map<String, dynamic> _$WebpImagesModelToJson(WebpImagesModel instance) =>
    <String, dynamic>{
      'image_url': instance.imageUrl,
      'small_image_url': instance.smallImageUrl,
      'large_image_url': instance.largeImageUrl,
    };

BroadcastModel _$BroadcastModelFromJson(Map<String, dynamic> json) =>
    BroadcastModel(
      day: json['day'] as String? ?? '',
      time: json['time'] as String? ?? '',
      timezone: json['timezone'] as String? ?? '',
      string: json['string'] as String? ?? '',
    );

Map<String, dynamic> _$BroadcastModelToJson(BroadcastModel instance) =>
    <String, dynamic>{
      'day': instance.day,
      'time': instance.time,
      'timezone': instance.timezone,
      'string': instance.string,
    };
