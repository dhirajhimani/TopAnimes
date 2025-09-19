import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/light_novel.dart';

part 'light_novel_model.g.dart';

/// Data Transfer Object for Light Novel from RanobeDB API
@JsonSerializable()
class LightNovelModel {
  /// Unique ID of the light novel
  final int id;
  
  /// Title of the light novel
  final String title;
  
  /// Description/synopsis of the light novel
  final String? description;
  
  /// Cover image URL
  @JsonKey(name: 'cover_url')
  final String? coverUrl;
  
  /// Publication status
  final String? status;
  
  /// Year of publication
  final int? year;
  
  /// Number of volumes
  @JsonKey(name: 'volume_count')
  final int? volumeCount;
  
  /// Authors information
  final List<AuthorModel>? authors;
  
  /// Language of the light novel
  final String? language;
  
  /// Web URLs for the light novel
  final List<WebUrlModel>? webUrls;
  
  /// Creates a [LightNovelModel]
  const LightNovelModel({
    required this.id,
    required this.title,
    this.description,
    this.coverUrl,
    this.status,
    this.year,
    this.volumeCount,
    this.authors,
    this.language,
    this.webUrls,
  });
  
  /// Creates a [LightNovelModel] from JSON
  factory LightNovelModel.fromJson(Map<String, dynamic> json) => 
      _$LightNovelModelFromJson(json);
  
  /// Converts this [LightNovelModel] to JSON
  Map<String, dynamic> toJson() => _$LightNovelModelToJson(this);
  
  /// Converts this [LightNovelModel] to a domain [LightNovel] entity
  LightNovel toEntity() {
    final authorNames = authors?.map((author) => author.name).toList() ?? [];
    final primaryUrl = webUrls?.isNotEmpty == true 
        ? webUrls!.first.url 
        : 'https://ranobedb.org/novel/$id';
    
    return LightNovel(
      id: id,
      title: title,
      url: primaryUrl,
      imageUrl: coverUrl ?? '',
      synopsis: description ?? '',
      status: status ?? 'Unknown',
      year: year,
      volumes: volumeCount,
      authors: authorNames,
      language: language ?? 'Unknown',
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
      year: lightNovel.year,
      volumeCount: lightNovel.volumes,
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
  final int id;
  
  /// Author name
  final String name;
  
  /// Creates an [AuthorModel]
  const AuthorModel({
    required this.id,
    required this.name,
  });
  
  factory AuthorModel.fromJson(Map<String, dynamic> json) => 
      _$AuthorModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$AuthorModelToJson(this);
}

/// Web URL model for light novel external links
@JsonSerializable()
class WebUrlModel {
  /// URL string
  final String url;
  
  /// Type of URL (e.g., 'official', 'publisher')
  final String type;
  
  /// Creates a [WebUrlModel]
  const WebUrlModel({
    required this.url,
    required this.type,
  });
  
  factory WebUrlModel.fromJson(Map<String, dynamic> json) => 
      _$WebUrlModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$WebUrlModelToJson(this);
}