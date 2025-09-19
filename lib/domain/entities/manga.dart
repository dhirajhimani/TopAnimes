import 'package:equatable/equatable.dart';

/// Domain entity representing a manga
class Manga extends Equatable {
  /// Unique identifier for the manga from MyAnimeList
  final int id;
  
  /// Official title of the manga
  final String title;
  
  /// Official web URL for the manga on MyAnimeList
  final String url;
  
  /// URL for the manga's cover/poster image
  final String imageUrl;
  
  /// Plot synopsis or description of the manga
  final String synopsis;
  
  /// User rating score out of 10 (optional)
  final double? score;
  
  /// Current publication status (e.g., "Publishing", "Finished")
  final String status;
  
  /// Total number of chapters (optional, may be unknown for ongoing series)
  final int? chapters;
  
  /// Total number of volumes (optional, may be unknown for ongoing series)
  final int? volumes;
  
  /// Number of MyAnimeList members who have this manga in their list
  final int members;
  
  /// Creates a [Manga] entity with all required and optional parameters
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