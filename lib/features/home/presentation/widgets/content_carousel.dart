import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../domain/entities/content.dart';

/// Horizontal carousel for displaying content items
class ContentCarousel extends StatelessWidget {
  /// List of content items to display
  final List<Content> items;
  
  /// Callback when an item is tapped
  final Function(Content)? onItemTap;
  
  /// Creates a [ContentCarousel]
  const ContentCarousel({
    super.key,
    required this.items,
    this.onItemTap,
  });
  
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const _EmptyCarouselWidget();
    }
    
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final content = items[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == items.length - 1 ? 16 : 12,
              left: index == 0 ? 0 : 0,
            ),
            child: ContentCard(
              content: content,
              onTap: onItemTap != null ? () => onItemTap!(content) : null,
            ),
          );
        },
      ),
    );
  }
}

/// Individual content card for the carousel
class ContentCard extends StatelessWidget {
  /// Content to display
  final Content content;
  
  /// Callback when the card is tapped
  final VoidCallback? onTap;
  
  /// Creates a [ContentCard]
  const ContentCard({
    super.key,
    required this.content,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SizedBox(
      width: 160,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Content Image
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    imageUrl: content.imageUrl,
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _getContentIcon(content.type),
                            color: Colors.grey[600],
                            size: 32,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _getContentTypeLabel(content.type),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              
              // Content Details
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Content Type Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getContentTypeColor(content.type),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _getContentTypeLabel(content.type).toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Title
                      Expanded(
                        child: Text(
                          content.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      
                      const SizedBox(height: 4),
                      
                      // Score or Status
                      Row(
                        children: [
                          if (content.score != null) ...[
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              content.score!.toStringAsFixed(1),
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ] else ...[
                            Icon(
                              Icons.info_outline,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                content.status,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[600],
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// Gets the appropriate icon for content type
  IconData _getContentIcon(ContentType type) {
    switch (type) {
      case ContentType.anime:
        return Icons.play_circle_outline;
      case ContentType.manga:
        return Icons.book_outlined;
      case ContentType.lightNovel:
        return Icons.menu_book_outlined;
    }
  }
  
  /// Gets the label for content type
  String _getContentTypeLabel(ContentType type) {
    switch (type) {
      case ContentType.anime:
        return 'Anime';
      case ContentType.manga:
        return 'Manga';
      case ContentType.lightNovel:
        return 'Light Novel';
    }
  }
  
  /// Gets the color for content type
  Color _getContentTypeColor(ContentType type) {
    switch (type) {
      case ContentType.anime:
        return Colors.blue;
      case ContentType.manga:
        return Colors.green;
      case ContentType.lightNovel:
        return Colors.purple;
    }
  }
}

/// Widget displayed when carousel is empty
class _EmptyCarouselWidget extends StatelessWidget {
  const _EmptyCarouselWidget();
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: 280,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.inbox_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              'No content available',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}