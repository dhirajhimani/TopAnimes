import 'package:equatable/equatable.dart';

/// Domain entity representing a manga
class Manga extends Equatable {
  /// Unique ID of the manga
  final int id;
  
  /// Title of the manga
  final String title;
  
  /// Web URL of the manga
  final String url;
  
  /// Image URL of the manga
  final String imageUrl;
  
  /// Synopsis of the manga
  final String synopsis;
  
  /// Score/rating of the manga
  final double? score;
  
  /// Publication status of the manga
  final String status;
  
  /// Number of chapters
  final int? chapters;
  
  /// Number of volumes
  final int? volumes;
  
  /// Number of members who have this manga in their list
  final int members;
  
  /// Creates a [Manga] entity
  const Manga({
    required this.id,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.synopsis,
    this.score,
    required this.status,
    this.chapters,
    this.volumes,
    required this.members,
  });
  
  @override
  List<Object?> get props => [
    id, title, url, imageUrl, synopsis, score, 
    status, chapters, volumes, members
  ];
  
  @override
  String toString() {
    return 'Manga(id: $id, title: $title, url: $url, imageUrl: $imageUrl, '
           'synopsis: $synopsis, score: $score, status: $status, '
           'chapters: $chapters, volumes: $volumes, members: $members)';
  }
}