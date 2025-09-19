import 'package:equatable/equatable.dart';

/// Domain entity representing an anime
class Anime extends Equatable {
  /// Rank of the anime
  final int rank;
  
  /// Title of the anime
  final String title;
  
  /// Web URL of the anime
  final String url;
  
  /// Image URL of the anime
  final String imageUrl;
  
  /// Number of members who have this anime in their list
  final int members;
  
  /// Creates an [Anime] entity
  const Anime({
    required this.rank,
    required this.title,
    required this.url,
    required this.imageUrl,
    required this.members,
  });
  
  @override
  List<Object> get props => [rank, title, url, imageUrl, members];
  
  @override
  String toString() {
    return 'Anime(rank: $rank, title: $title, url: $url, imageUrl: $imageUrl, members: $members)';
  }
}