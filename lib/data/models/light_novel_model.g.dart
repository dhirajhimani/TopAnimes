// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_novel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightNovelModel _$LightNovelModelFromJson(Map<String, dynamic> json) =>
    LightNovelModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      coverUrl: json['cover_url'] as String?,
      status: json['status'] as String?,
      year: (json['year'] as num?)?.toInt(),
      volumeCount: (json['volume_count'] as num?)?.toInt(),
      authors: (json['authors'] as List<dynamic>?)
          ?.map((e) => AuthorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      language: json['language'] as String?,
      webUrls: (json['webUrls'] as List<dynamic>?)
          ?.map((e) => WebUrlModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LightNovelModelToJson(LightNovelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'cover_url': instance.coverUrl,
      'status': instance.status,
      'year': instance.year,
      'volume_count': instance.volumeCount,
      'authors': instance.authors,
      'language': instance.language,
      'webUrls': instance.webUrls,
    };

AuthorModel _$AuthorModelFromJson(Map<String, dynamic> json) => AuthorModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$AuthorModelToJson(AuthorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

WebUrlModel _$WebUrlModelFromJson(Map<String, dynamic> json) => WebUrlModel(
      url: json['url'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$WebUrlModelToJson(WebUrlModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'type': instance.type,
    };