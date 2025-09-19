import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../domain/entities/anime.dart';

/// Widget that displays an individual anime item in a card format
class AnimeCard extends StatelessWidget {
  /// The anime to display
  final Anime anime;
  
  /// Callback when the card is tapped
  final VoidCallback? onTap;
  
  /// Creates an [AnimeCard]
  const AnimeCard({
    super.key,
    required this.anime,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Anime Image
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: anime.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ),
            
            // Anime Details
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rank Badge (if available)
                    if (anime.rank != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '#${anime.rank}',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    
                    const SizedBox(height: 8),
                    
                    // Title
                    Expanded(
                      child: Text(
                        anime.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Members Count
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatMembers(anime.members),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  /// Formats the members count for display
  String _formatMembers(int members) {
    if (members >= 1000000) {
      return '${(members / 1000000).toStringAsFixed(1)}M';
    } else if (members >= 1000) {
      return '${(members / 1000).toStringAsFixed(1)}K';
    } else {
      return members.toString();
    }
  }
}