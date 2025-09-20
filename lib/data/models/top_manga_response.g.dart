// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_manga_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopMangaResponse _$TopMangaResponseFromJson(Map<String, dynamic> json) =>
    TopMangaResponse(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => MangaModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pagination:
          PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TopMangaResponseToJson(TopMangaResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
    };
