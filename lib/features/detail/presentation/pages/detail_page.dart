import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../domain/entities/content.dart';
import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../bloc/detail_bloc.dart';
import '../bloc/detail_event.dart';
import '../bloc/detail_state.dart';
import '../widgets/detail_info_card.dart';
import '../widgets/metadata_chip.dart';

/// Universal detail screen for anime, manga, and light novels
class DetailPage extends StatelessWidget {
  /// Content to display details for
  final Content content;

  /// Creates a [DetailPage]
  const DetailPage({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailBloc(favoritesBloc: context.read<FavoritesBloc>())
            ..add(LoadContentDetail(content)),
      child: BlocBuilder<DetailBloc, DetailState>(
        builder: (context, state) {
          // Get dynamic theme based on extracted color
          final theme = _buildAdaptiveTheme(context, state);

          return Theme(
            data: theme,
            child: Scaffold(
              body: CustomScrollView(
                slivers: [
                  _buildSliverAppBar(context, state),
                  SliverToBoxAdapter(child: _buildContent(context, state)),
                ],
              ),
              floatingActionButton: _buildFloatingActionButtons(context, state),
            ),
          );
        },
      ),
    );
  }

  /// Builds adaptive theme based on dominant color
  ThemeData _buildAdaptiveTheme(BuildContext context, DetailState state) {
    final baseTheme = Theme.of(context);

    if (state is DetailLoaded && state.dominantColor != null) {
      final dominantColor = state.dominantColor!;

      // Create a color scheme from the dominant color
      final colorScheme = ColorScheme.fromSeed(
        seedColor: dominantColor,
        brightness: baseTheme.brightness,
      );

      return baseTheme.copyWith(
        colorScheme: colorScheme,
        appBarTheme: baseTheme.appBarTheme.copyWith(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
        ),
        floatingActionButtonTheme: baseTheme.floatingActionButtonTheme.copyWith(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      );
    }

    return baseTheme;
  }

  /// Builds the sliver app bar with image background
  Widget _buildSliverAppBar(BuildContext context, DetailState state) {
    final currentContent = _getCurrentContent(state);

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () async {
          if (currentContent.type == ContentType.anime) {
            context.go('/anime', extra: currentContent);
            return;
          }
          if (currentContent.type == ContentType.manga) {
            context.go('/manga', extra: currentContent);
            return;
          }
          if (currentContent.type == ContentType.lightNovel) {
            context.go('/light_novel', extra: currentContent);
            return;
          }
        },
      ),
      actions: [
        // Color indicator when dominant color is extracted
        if (state is DetailLoaded && state.dominantColor != null)
          Container(
            margin: const EdgeInsets.all(8),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: state.dominantColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        if (state is DetailLoaded)
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<DetailBloc>().add(
                RefreshContentDetail(state.content),
              );
            },
          ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: currentContent.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[300],
                child: const Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _getContentIcon(currentContent.type),
                      size: 64,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getContentTypeLabel(currentContent.type),
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the main content area
  Widget _buildContent(BuildContext context, DetailState state) {
    if (state is DetailLoading) {
      return const _LoadingWidget();
    } else if (state is DetailLoaded) {
      return _buildDetailContent(context, state.content);
    } else if (state is DetailError) {
      return _ErrorWidget(
        content: state.content,
        message: state.message,
        onRetry: () =>
            context.read<DetailBloc>().add(LoadContentDetail(state.content)),
      );
    }

    return _buildDetailContent(context, content);
  }

  /// Builds the detailed content section
  Widget _buildDetailContent(BuildContext context, Content content) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and type badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  content.title,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: _getContentTypeColor(content.type),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _getContentTypeLabel(content.type).toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Score and status
          Row(
            children: [
              if (content.score != null) ...[
                Icon(Icons.star, color: Colors.amber[600], size: 20),
                const SizedBox(width: 4),
                Text(
                  content.score!.toStringAsFixed(1),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 16),
              ],
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  content.status,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Metadata chips
          _buildMetadataChips(content),

          const SizedBox(height: 24),

          // Synopsis
          DetailInfoCard(
            title: 'Synopsis',
            icon: Icons.description_outlined,
            child: Text(
              content.synopsis.isNotEmpty
                  ? content.synopsis
                  : 'No synopsis available.',
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
          ),

          const SizedBox(height: 16),

          // Additional information based on content type
          _buildTypeSpecificInfo(context, content),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  /// Builds metadata chips
  Widget _buildMetadataChips(Content content) {
    final metadata = content.metadata;
    final chips = <Widget>[];

    // Common metadata
    if (content.members > 0) {
      chips.add(
        MetadataChip(
          label: '${_formatNumber(content.members)} members',
          icon: Icons.people,
        ),
      );
    }

    // Type-specific metadata
    switch (content.type) {
      case ContentType.anime:
        if (metadata['episodes'] != null) {
          chips.add(
            MetadataChip(
              label: '${metadata['episodes']} episodes',
              icon: Icons.play_circle_outline,
            ),
          );
        }
        if (metadata['season'] != null) {
          chips.add(
            MetadataChip(
              label: metadata['season'] as String,
              icon: Icons.calendar_today,
            ),
          );
        }
        break;

      case ContentType.manga:
        if (metadata['volumes'] != null) {
          chips.add(
            MetadataChip(
              label: '${metadata['volumes']} volumes',
              icon: Icons.book,
            ),
          );
        }
        if (metadata['chapters'] != null) {
          chips.add(
            MetadataChip(
              label: '${metadata['chapters']} chapters',
              icon: Icons.article,
            ),
          );
        }
        break;

      case ContentType.lightNovel:
        if (metadata['volumes'] != null) {
          chips.add(
            MetadataChip(
              label: '${metadata['volumes']} volumes',
              icon: Icons.menu_book,
            ),
          );
        }
        if (metadata['language'] != null) {
          chips.add(
            MetadataChip(
              label: metadata['language'] as String,
              icon: Icons.language,
            ),
          );
        }
        break;
    }

    if (chips.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(spacing: 8, runSpacing: 8, children: chips);
  }

  /// Builds type-specific information
  Widget _buildTypeSpecificInfo(BuildContext context, Content content) {
    final metadata = content.metadata;

    switch (content.type) {
      case ContentType.anime:
        if (metadata['broadcast'] != null) {
          return DetailInfoCard(
            title: 'Broadcast',
            icon: Icons.tv,
            child: Text(
              metadata['broadcast'] as String,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        break;

      case ContentType.lightNovel:
        var metadataAuthors = metadata['authors'] as List<dynamic>?;
        if (metadataAuthors != null && metadataAuthors.isNotEmpty) {
          final authors = metadataAuthors as List<String>;
          return DetailInfoCard(
            title: 'Authors',
            icon: Icons.person,
            child: Text(
              authors.join(', '),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }
        break;

      case ContentType.manga:
        // Could add publisher, demographic, etc.
        break;
    }

    return const SizedBox.shrink();
  }

  /// Builds floating action buttons
  Widget? _buildFloatingActionButtons(BuildContext context, DetailState state) {
    final currentContent = _getCurrentContent(state);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Favorite button
        if (state is DetailLoaded)
          FloatingActionButton(
            heroTag: "favorite",
            onPressed: () {
              context.read<DetailBloc>().add(ToggleFavorite(currentContent));
            },
            child: Icon(
              state.isFavorite ? Icons.favorite : Icons.favorite_border,
              color: state.isFavorite ? Colors.red : null,
            ),
          ),

        if (state is DetailLoaded && currentContent.url.isNotEmpty)
          const SizedBox(height: 16),

        // View on web button
        if (currentContent.url.isNotEmpty)
          FloatingActionButton.extended(
            heroTag: "view_web",
            onPressed: () => _openUrl(context, currentContent.url),
            icon: const Icon(Icons.open_in_new),
            label: const Text('View on Web'),
          ),
      ],
    );
  }

  /// Gets the current content based on state
  Content _getCurrentContent(DetailState state) {
    if (state is DetailLoaded) {
      return state.content;
    } else if (state is DetailError) {
      return state.content;
    } else if (state is DetailLoading) {
      return state.content;
    }
    return content;
  }

  /// Opens URL in browser
  Future<void> _openUrl(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showSnackBar(context, 'Could not open the link');
      }
    } catch (e) {
      _showSnackBar(context, 'Error opening link');
    }
  }

  /// Shows a snackbar message
  void _showSnackBar(BuildContext context, String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
      );
    }
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

  /// Formats numbers for display
  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toString();
    }
  }
}

/// Widget displayed while loading detail data
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading details...'),
          ],
        ),
      ),
    );
  }
}

/// Widget displayed when an error occurs
class _ErrorWidget extends StatelessWidget {
  /// Content that failed to load
  final Content content;

  /// Error message to display
  final String message;

  /// Callback when retry button is pressed
  final VoidCallback? onRetry;

  const _ErrorWidget({
    required this.content,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(
              'Failed to load details',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
          ],
        ),
      ),
    );
  }
}
