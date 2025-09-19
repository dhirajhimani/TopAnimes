// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaModel _$MangaModelFromJson(Map<String, dynamic> json) => MangaModel(
  id: (json['mal_id'] as num).toInt(),
  title: json['title'] as String,
  url: json['url'] as String,
  images: ImagesModel.fromJson(json['images'] as Map<String, dynamic>),
  synopsis: json['synopsis'] as String?,
  score: (json['score'] as num?)?.toDouble(),
  status: json['status'] as String,
  chapters: (json['chapters'] as num?)?.toInt(),
  volumes: (json['volumes'] as num?)?.toInt(),
  members: (json['members'] as num).toInt(),
);

Map<String, dynamic> _$MangaModelToJson(MangaModel instance) =>
    <String, dynamic>{
      'mal_id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'images': instance.images,
      'synopsis': instance.synopsis,
      'score': instance.score,
      'status': instance.status,
      'chapters': instance.chapters,
      'volumes': instance.volumes,
      'members': instance.members,
    };
