import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/light_novel.dart';

part 'light_novel_model.g.dart';

/// Data Transfer Object for Light Novel from RanobeDB API
@JsonSerializable()
class LightNovelModel {
  /// Unique ID of the light novel
  @JsonKey(defaultValue: 0)
  final int id;
  
  /// Title of the light novel
  @JsonKey(defaultValue: '')
  final String title;
  
  /// Description/synopsis of the light novel
  @JsonKey(defaultValue: '')
  final String description;

  /// Cover image URL
  @JsonKey(name: 'cover_url', defaultValue: '')
  final String coverUrl;

  /// Publication status
  @JsonKey(defaultValue: '')
  final String status;

  /// Year of publication
  @JsonKey(defaultValue: 0)
  final int year;

  /// Number of volumes
  @JsonKey(name: 'volume_count', defaultValue: 0)
  final int volumeCount;

  /// Authors information
  @JsonKey(defaultValue: [])
  final List<AuthorModel> authors;

  /// Language of the light novel
  @JsonKey(defaultValue: '')
  final String language;

  /// Web URLs for the light novel
  @JsonKey(defaultValue: [])
  final List<WebUrlModel> webUrls;

  /// Creates a [LightNovelModel]
  const LightNovelModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.status,
    required this.year,
    required this.volumeCount,
    required this.authors,
    required this.language,
    required this.webUrls,
  });
  
  /// Creates a [LightNovelModel] from JSON
  factory LightNovelModel.fromJson(Map<String, dynamic> json) {
    return LightNovelModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      coverUrl: json['cover_url'] as String? ?? '',
      status: json['status'] as String? ?? '',
      year: json['year'] as int? ?? 0,
      volumeCount: json['volume_count'] as int? ?? 0,
      authors: (json['authors'] as List<dynamic>?)?.map((e) => AuthorModel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      language: json['language'] as String? ?? '',
      webUrls: (json['webUrls'] as List<dynamic>?)?.map((e) => WebUrlModel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  /// Converts this [LightNovelModel] to JSON
  Map<String, dynamic> toJson() => _$LightNovelModelToJson(this);
  
  /// Converts this [LightNovelModel] to a domain [LightNovel] entity
  LightNovel toEntity() {
    final authorNames = authors.isNotEmpty ? authors.map((author) => author.name).toList() : <String>[];
    final primaryUrl = webUrls.isNotEmpty
        ? webUrls.first.url
        : 'https://ranobedb.org/novel/$id';
    
    return LightNovel(
      id: id,
      title: title,
      url: primaryUrl,
      imageUrl: coverUrl,
      synopsis: description,
      status: status.isNotEmpty ? status : 'Unknown',
      year: year,
      volumes: volumeCount,
      authors: authorNames,
      language: language.isNotEmpty ? language : 'Unknown',
    );
  }
  
  /// Creates a [LightNovelModel] from a domain [LightNovel] entity
  factory LightNovelModel.fromEntity(LightNovel lightNovel) {
    final authorModels = lightNovel.authors
        .map((name) => AuthorModel(id: 0, name: name))
        .toList();
    
    return LightNovelModel(
      id: lightNovel.id,
      title: lightNovel.title,
      description: lightNovel.synopsis,
      coverUrl: lightNovel.imageUrl,
      status: lightNovel.status,
      year: lightNovel.year ?? 0,
      volumeCount: lightNovel.volumes ?? 0,
      authors: authorModels,
      language: lightNovel.language,
      webUrls: [WebUrlModel(url: lightNovel.url, type: 'main')],
    );
  }
}

/// Author model for light novel authors
@JsonSerializable()
class AuthorModel {
  /// Author ID
  @JsonKey(defaultValue: 0)
  final int id;
  
  /// Author name
  @JsonKey(defaultValue: '')
  final String name;
  
  /// Creates an [AuthorModel]
  const AuthorModel({
    required this.id,
    required this.name,
  });
  
  factory AuthorModel.fromJson(Map<String, dynamic> json) => AuthorModel(
    id: json['id'] as int? ?? 0,
    name: json['name'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => _$AuthorModelToJson(this);
}

/// Web URL model for light novel external links
@JsonSerializable()
class WebUrlModel {
  /// URL string
  @JsonKey(defaultValue: '')
  final String url;
  
  /// Type of URL (e.g., 'official', 'publisher')
  @JsonKey(defaultValue: '')
  final String type;
  
  /// Creates a [WebUrlModel]
  const WebUrlModel({
    required this.url,
    required this.type,
  });
  
  factory WebUrlModel.fromJson(Map<String, dynamic> json) => WebUrlModel(
    url: json['url'] as String? ?? '',
    type: json['type'] as String? ?? '',
  );

  Map<String, dynamic> toJson() => _$WebUrlModelToJson(this);
}