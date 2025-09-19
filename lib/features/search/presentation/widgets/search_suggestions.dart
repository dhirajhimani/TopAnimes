import 'package:flutter/material.dart';

/// Widget for displaying search suggestions when no search is active
class SearchSuggestions extends StatelessWidget {
  /// Callback when a suggestion is tapped
  final Function(String)? onSuggestionTap;
  
  /// Creates a [SearchSuggestions]
  const SearchSuggestions({
    super.key,
    this.onSuggestionTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular searches section
          Text(
            'Popular Searches',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _popularSearches.map((search) => _SuggestionChip(
              label: search,
              onTap: () => onSuggestionTap?.call(search),
            )).toList(),
          ),
          
          const SizedBox(height: 32),
          
          // Content categories section
          Text(
            'Browse by Category',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          
          _CategoryCard(
            title: 'Anime',
            subtitle: 'Discover amazing anime series',
            icon: Icons.play_circle_outline,
            color: Colors.blue,
            onTap: () => onSuggestionTap?.call('anime'),
          ),
          
          const SizedBox(height: 12),
          
          _CategoryCard(
            title: 'Manga',
            subtitle: 'Explore manga collections',
            icon: Icons.book_outlined,
            color: Colors.green,
            onTap: () => onSuggestionTap?.call('manga'),
          ),
          
          const SizedBox(height: 12),
          
          _CategoryCard(
            title: 'Light Novels',
            subtitle: 'Browse Japanese light novels',
            icon: Icons.menu_book_outlined,
            color: Colors.purple,
            onTap: () => onSuggestionTap?.call('light novel'),
          ),
          
          const SizedBox(height: 32),
          
          // Search tips
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: theme.primaryColor.withOpacity(0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: theme.primaryColor,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Search Tips',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ..._searchTips.map((tip) => Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: theme.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          tip,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.primaryColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  /// Popular search terms
  static const List<String> _popularSearches = [
    'Attack on Titan',
    'One Piece',
    'Demon Slayer',
    'Naruto',
    'Dragon Ball',
    'Death Note',
    'My Hero Academia',
    'Sword Art Online',
  ];
  
  /// Search tips for users
  static const List<String> _searchTips = [
    'Search by title, author, or genre',
    'Use specific keywords for better results',
    'Try both English and Japanese titles',
    'Browse by content type for targeted results',
  ];
}

/// Chip widget for search suggestions
class _SuggestionChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  
  const _SuggestionChip({
    required this.label,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return ActionChip(
      label: Text(label),
      onPressed: onTap,
      backgroundColor: theme.colorScheme.surface,
      side: BorderSide(
        color: theme.primaryColor.withOpacity(0.3),
      ),
      labelStyle: TextStyle(
        color: theme.primaryColor,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

/// Card widget for content categories
class _CategoryCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  
  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}