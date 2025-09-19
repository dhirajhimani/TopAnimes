import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/home_cubit.dart';
import '../widgets/anime_card.dart';
import '../widgets/manga_card.dart';

/// Main home page displaying top anime and manga
class HomePage extends StatelessWidget {
  /// Creates a [HomePage]
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Otaku Hub Lite',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.go('/settings'),
            tooltip: 'Settings',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<HomeCubit>().refreshHomeData();
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            // Load data when the page is first opened
            context.read<HomeCubit>().loadHomeData();
            return const _LoadingWidget();
          } else if (state is HomeLoading) {
            return const _LoadingWidget();
          } else if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<HomeCubit>().refreshHomeData(),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome section with status indicator
                    _buildWelcomeSection(context, state),
                    const SizedBox(height: 24),
                    
                    // Top Airing Anime section
                    _buildSectionHeader(
                      context,
                      'Top Airing Anime',
                      Icons.play_circle_outline,
                    ),
                    const SizedBox(height: 16),
                    _buildAnimeGrid(state.topAiringAnime),
                    const SizedBox(height: 32),
                    
                    // Top Manga section
                    _buildSectionHeader(
                      context,
                      'Top Manga',
                      Icons.book_outlined,
                    ),
                    const SizedBox(height: 16),
                    _buildMangaGrid(state.topManga),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          } else if (state is HomeError) {
            return _ErrorWidget(
              message: state.message,
              onRetry: () => context.read<HomeCubit>().loadHomeData(),
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }
  
  /// Builds the welcome section with data source indicator
  Widget _buildWelcomeSection(BuildContext context, HomeLoaded state) {
    final theme = Theme.of(context);
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.primaryColor,
            theme.primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Welcome to Otaku Hub Lite',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (state.usingMockData)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.theater_comedy,
                        size: 16,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'MOCK',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            state.usingMockData
                ? 'Displaying sample data for demonstration'
                : 'Discover the latest anime and manga',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
  
  /// Builds a section header
  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    final theme = Theme.of(context);
    
    return Row(
      children: [
        Icon(
          icon,
          color: theme.primaryColor,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
  
  /// Builds the anime grid
  Widget _buildAnimeGrid(List<dynamic> animeList) {
    if (animeList.isEmpty) {
      return const _EmptyStateWidget(
        icon: Icons.play_circle_outline,
        message: 'No anime data available',
      );
    }
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: animeList.length.clamp(0, 6), // Limit to 6 items for home
      itemBuilder: (context, index) {
        final anime = animeList[index];
        return AnimeCard(anime: anime);
      },
    );
  }
  
  /// Builds the manga grid
  Widget _buildMangaGrid(List<dynamic> mangaList) {
    if (mangaList.isEmpty) {
      return const _EmptyStateWidget(
        icon: Icons.book_outlined,
        message: 'No manga data available',
      );
    }
    
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: mangaList.length.clamp(0, 6), // Limit to 6 items for home
      itemBuilder: (context, index) {
        final manga = mangaList[index];
        return MangaCard(manga: manga);
      },
    );
  }
}

/// Widget displayed while loading home data
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
          Text('Loading amazing content...'),
        ],
      ),
    );
  }
}

/// Widget displayed when an error occurs
class _ErrorWidget extends StatelessWidget {
  /// Error message to display
  final String message;
  
  /// Callback when retry button is pressed
  final VoidCallback? onRetry;
  
  const _ErrorWidget({
    required this.message,
    this.onRetry,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red[300],
            ),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
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

/// Widget displayed when content is empty
class _EmptyStateWidget extends StatelessWidget {
  /// Icon to display
  final IconData icon;
  
  /// Message to display
  final String message;
  
  const _EmptyStateWidget({
    required this.icon,
    required this.message,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Container(
      height: 200,
      width: double.infinity,
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
              icon,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              message,
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