import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:top_anime/features/home/presentation/bloc/home_event.dart';
import '../../../../domain/entities/content.dart';
import '../../../home/presentation/bloc/home_bloc.dart';
import '../../../home/presentation/bloc/home_state.dart';

/// Page displaying the list of anime
class AnimeListPage extends StatelessWidget {
  /// Creates an [AnimeListPage]
  const AnimeListPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Anime',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.go('/search'),
            tooltip: 'Search',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Trigger refresh from home bloc
              final homeBloc = context.read<HomeBloc?>();
              if (homeBloc != null) {
                homeBloc.add(const RefreshHomeData());
              }
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const _LoadingWidget();
          } else if (state is HomeLoaded) {
            // Filter for anime content from top airing
            // final animeList = state.topAiringAnime.where((content) => content.type == ContentType.anime).toList();
            final animeList = state.topAiringAnime;

            if (animeList.isEmpty) {
              return const _EmptyStateWidget(
                icon: Icons.movie_outlined,
                message: 'No anime found',
              );
            }
            
            return RefreshIndicator(
              onRefresh: () async {
                final homeBloc = context.read<HomeBloc?>();
                if (homeBloc != null) {
                  homeBloc.add(const RefreshHomeData());
                }
              },
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: animeList.length,
                itemBuilder: (context, index) {
                  final anime = animeList[index];
                  final content = Content.fromAnime(anime);
                  return GestureDetector(
                    onTap: () => context.go('/detail', extra: content),
                    child: _buildContentCard(context, content),
                  );
                },
              ),
            );
          } else if (state is HomeError) {
            return _ErrorWidget(
              message: state.message,
              onRetry: () {
                final homeBloc = context.read<HomeBloc?>();
                if (homeBloc != null) {
                  homeBloc.add(const LoadHomeData());
                }
              },
            );
          }
          
          return const _LoadingWidget();
        },
      ),
    );
  }
  
  /// Builds a content card widget
  Widget _buildContentCard(BuildContext context, Content content) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  content.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: const Icon(
                      Icons.movie,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (content.score != null)
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          content.score!.toStringAsFixed(1),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
    );
  }
}

/// Loading widget
class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();
  
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading anime...'),
        ],
      ),
    );
  }
}

/// Empty state widget
class _EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String message;
  
  const _EmptyStateWidget({
    required this.icon,
    required this.message,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

/// Error widget
class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  
  const _ErrorWidget({
    required this.message,
    required this.onRetry,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
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