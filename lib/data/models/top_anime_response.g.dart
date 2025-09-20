// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_anime_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopAnimeResponse _$TopAnimeResponseFromJson(Map<String, dynamic> json) =>
    TopAnimeResponse(
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => AnimeModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      pagination: PaginationModel.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$TopAnimeResponseToJson(TopAnimeResponse instance) =>
    <String, dynamic>{'data': instance.data, 'pagination': instance.pagination};

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      lastVisiblePage: (json['last_visible_page'] as num?)?.toInt() ?? 0,
      hasNextPage: json['has_next_page'] as bool? ?? false,
      currentPage: (json['current_page'] as num?)?.toInt() ?? 0,
      items: ItemsModel.fromJson(json['items'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'last_visible_page': instance.lastVisiblePage,
      'has_next_page': instance.hasNextPage,
      'current_page': instance.currentPage,
      'items': instance.items,
    };

ItemsModel _$ItemsModelFromJson(Map<String, dynamic> json) => ItemsModel(
  count: (json['count'] as num?)?.toInt() ?? 0,
  total: (json['total'] as num?)?.toInt() ?? 0,
  perPage: (json['per_page'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ItemsModelToJson(ItemsModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'total': instance.total,
      'per_page': instance.perPage,
    };
