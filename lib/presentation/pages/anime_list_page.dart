import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubit/anime_cubit.dart';
import '../cubit/anime_state.dart';
import '../widgets/anime_card.dart';

/// Main page displaying the list of top anime
class AnimeListPage extends StatelessWidget {
  /// Creates an [AnimeListPage]
  const AnimeListPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TopAnimes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<AnimeCubit>().refreshAnime();
            },
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocBuilder<AnimeCubit, AnimeState>(
        builder: (context, state) {
          if (state is AnimeInitial) {
            // Load anime when the page is first opened
            context.read<AnimeCubit>().loadTopAnime();
            return const _LoadingWidget();
          } else if (state is AnimeLoading) {
            return const _LoadingWidget();
          } else if (state is AnimeLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<AnimeCubit>().refreshAnime(),
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: state.animeList.length,
                itemBuilder: (context, index) {
                  final anime = state.animeList[index];
                  return AnimeCard(
                    anime: anime,
                    onTap: () => _openAnimeUrl(context, anime.url),
                  );
                },
              ),
            );
          } else if (state is AnimeError) {
            return _ErrorWidget(
              message: state.message,
              onRetry: () => context.read<AnimeCubit>().loadTopAnime(),
            );
          }
          
          return const SizedBox.shrink();
        },
      ),
    );
  }
  
  /// Opens the anime URL in the browser
  Future<void> _openAnimeUrl(BuildContext context, String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open anime page'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error opening anime page'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}

/// Widget displayed while loading anime data
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
          Text(
            'Loading awesome anime...',
            style: TextStyle(fontSize: 16),
          ),
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
  final VoidCallback onRetry;
  
  const _ErrorWidget({
    required this.message,
    required this.onRetry,
  });
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error,
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
              style: theme.textTheme.bodyMedium,
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