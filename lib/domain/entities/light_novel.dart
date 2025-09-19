import 'package:equatable/equatable.dart';

/// Domain entity representing a light novel
class LightNovel extends Equatable {
  /// Unique ID of the light novel
  final int id;
  
  /// Title of the light novel
  final String title;
  
  /// Web URL of the light novel
  final String url;
  
  /// Image URL of the light novel
  final String imageUrl;
  
  /// Synopsis of the light novel
  final String synopsis;
  
  /// Publication status of the light novel
  final String status;
  
  /// Year of publication
  final int? year;
  
  /// Number of volumes
  final int? volumes;
  
  /// Author(s) of the light novel
  final List<String> authors;
  
  /// Language of the light novel
  final String language;
  
  /// Creates a [LightNovel] entity
  const LightNovel({
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.synopsis,
    required this.status,
    this.year,
    this.volumes,
    required this.authors,
    required this.language,
  });
  
  @override
  List<Object?> get props => [
    id, title, url, imageUrl, synopsis, status, 
    year, volumes, authors, language
  ];
  
  @override
  String toString() {
    return 'LightNovel(id: $id, title: $title, url: $url, imageUrl: $imageUrl, '
           'synopsis: $synopsis, status: $status, year: $year, '
           'volumes: $volumes, authors: $authors, language: $language)';
  }
}