import 'package:equatable/equatable.dart';

/// Domain entity representing an anime
class Anime extends Equatable {
  /// Unique ID of the anime
  final int id;
  
  /// Rank of the anime (if applicable)
  final int? rank;
  
  /// Title of the anime
  final String title;
  
  /// Web URL of the anime
  final String url;
  
  /// Image URL of the anime
  final String imageUrl;
  
  /// Synopsis of the anime
  final String synopsis;
  
  /// Score/rating of the anime
  final double? score;
  
  /// Airing status of the anime
  final String status;
  
  /// Number of episodes
  final int? episodes;
  
  /// Airing season and year
  final String? season;
  
  /// Broadcast day and time
  final String? broadcast;
  
  /// Number of members who have this anime in their list
  final int members;
  
  /// Creates an [Anime] entity
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