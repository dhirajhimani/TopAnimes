// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light_novel_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LightNovelResponse _$LightNovelResponseFromJson(Map<String, dynamic> json) =>
    LightNovelResponse(
      results: (json['results'] as List<dynamic>?)
              ?.map((e) => LightNovelModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      count: (json['count'] as num?)?.toInt() ?? 0,
      next: json['next'] as String? ?? '',
      previous: json['previous'] as String? ?? '',
    );

Map<String, dynamic> _$LightNovelResponseToJson(LightNovelResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
    };
