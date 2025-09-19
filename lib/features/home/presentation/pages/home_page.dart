import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../domain/entities/content.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import '../widgets/content_carousel.dart';
import '../widgets/section_header.dart';

/// Main home screen displaying top anime and manga
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
            icon: const Icon(Icons.search),
            onPressed: () => context.go('/search'),
            tooltip: 'Search',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<HomeBloc>().add(const RefreshHomeData());
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeInitial) {
            // Load data when the page is first opened
            context.read<HomeBloc>().add(const LoadHomeData());
            return const _LoadingWidget();
          } else if (state is HomeLoading) {
            return const _LoadingWidget();
          } else if (state is HomeLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(const RefreshHomeData());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome section
                    _buildWelcomeSection(context),
                    const SizedBox(height: 24),
                    
                    // Top Airing Anime section
                    SectionHeader(
                      title: 'Top Airing Anime',
                      onSeeAllPressed: () {
                        // Navigate to full anime list
                        context.go('/anime');
                      },
                    ),
                    const SizedBox(height: 16),
                    ContentCarousel(
                      items: state.topAiringAnime
                          .map((anime) => Content.fromAnime(anime))
                          .toList(),
                      onItemTap: (content) {
                        context.go('/detail', extra: content);
                      },
                    ),
                    const SizedBox(height: 32),
                    
                    // Top Manga section
                    SectionHeader(
                      title: 'Top Manga',
                      onSeeAllPressed: () {
                        // Navigate to full manga list
                        context.go('/manga');
                      },
                    ),
                    const SizedBox(height: 16),
                    ContentCarousel(
                      items: state.topManga
                          .map((manga) => Content.fromManga(manga))
                          .toList(),
                      onItemTap: (content) {
                        context.go('/detail', extra: content);
                      },
                    ),
                    const SizedBox(height: 32),
                    
                    // Light Novels section
                    SectionHeader(
                      title: 'Light Novels',
                      subtitle: 'Discover Japanese light novels',
                      onSeeAllPressed: () {
                        context.go('/light-novels');
                      },
                    ),
                    const SizedBox(height: 16),
                    _buildLightNovelsCard(context),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          } else if (state is HomeError) {
            return _ErrorWidget(
              message: state.message,
              onRetry: () => context.read<HomeBloc>().add(const LoadHomeData()),
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }
  
  /// Builds the welcome section
  Widget _buildWelcomeSection(BuildContext context) {
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
          Text(
            'Welcome to Otaku Hub Lite',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Discover the latest anime, manga, and light novels',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
  
  /// Builds the light novels card
  Widget _buildLightNovelsCard(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () => context.go('/light-novels'),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                Icons.book,
                size: 48,
                color: theme.primaryColor,
              ),
              const SizedBox(height: 12),
              Text(
                'Browse Light Novels',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Explore the world of Japanese light novels',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
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