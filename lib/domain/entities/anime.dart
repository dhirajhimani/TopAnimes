import 'package:equatable/equatable.dart';

/// Domain entity representing an anime
class Anime extends Equatable {
  /// Unique identifier for the anime from MyAnimeList
  final int id;
  
  /// Rank position of the anime (optional, may be null for search results)
  final int? rank;
  
  /// Official title of the anime
  final String title;
  
  /// Official web URL for the anime on MyAnimeList
  final String url;
  
  /// URL for the anime's poster/cover image
  final String imageUrl;
  
  /// Plot synopsis or description of the anime
  final String synopsis;
  
  /// User rating score out of 10 (optional)
  final double? score;
  
  /// Current airing status (e.g., "Currently Airing", "Finished Airing")
  final String status;
  
  /// Total number of episodes (optional, may be unknown for ongoing series)
  final int? episodes;
  
  /// Season and year information (e.g., "Winter 2021")
  final String? season;
  
  /// Broadcast schedule information (e.g., "Sundays at 00:10 (JST)")
  final String? broadcast;
  
  /// Number of MyAnimeList members who have this anime in their list
  final int members;
  
  /// Creates an [Anime] entity with all required and optional parameters
  const Anime({
    required this.id,
    this.rank,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.synopsis,
    this.score,
    required this.status,
    this.episodes,
    this.season,
    this.broadcast,
    required this.members,
  });
  
  @override
  List<Object?> get props => [
    id, rank, title, url, imageUrl, synopsis, score, 
    status, episodes, season, broadcast, members
  ];
  
  @override
  String toString() {
    return 'Anime(id: $id, rank: $rank, title: $title, url: $url, imageUrl: $imageUrl, '
           'synopsis: $synopsis, score: $score, status: $status, episodes: $episodes, '
           'season: $season, broadcast: $broadcast, members: $members)';
  }
}