// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_anime_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopAnimeResponse _$TopAnimeResponseFromJson(Map<String, dynamic> json) =>
    TopAnimeResponse(
      top: (json['top'] as List<dynamic>)
          .map((e) => AnimeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopAnimeResponseToJson(TopAnimeResponse instance) =>
    <String, dynamic>{
      'top': instance.top,
    };