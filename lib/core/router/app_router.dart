import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/content.dart';
import '../../features/detail/presentation/pages/detail_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/anime/presentation/pages/anime_list_page.dart';
import '../../features/manga/presentation/pages/manga_list_page.dart';
import '../../features/light_novel/presentation/pages/light_novel_list_page.dart';
import '../../features/favorites/presentation/pages/favorites_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/main_shell/presentation/pages/main_shell.dart';

/// Application routes configuration
class AppRouter {
  /// Creates the router configuration
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/anime',
      routes: [
        // Shell route containing the main navigation tabs
        ShellRoute(
          builder: (context, state, child) {
            return MainShell(child: child);
          },
          routes: [
            // Anime tab route
            GoRoute(
              path: '/anime',
              name: 'anime',
              builder: (context, state) => const AnimeListPage(),
            ),
            
            // Manga tab route
            GoRoute(
              path: '/manga',
              name: 'manga',
              builder: (context, state) => const MangaListPage(),
            ),
            
            // Light Novel tab route
            GoRoute(
              path: '/lightnovel',
              name: 'lightnovel',
              builder: (context, state) => const LightNovelListPage(),
            ),
            
            // Favorites tab route
            GoRoute(
              path: '/favorites',
              name: 'favorites',
              builder: (context, state) => const FavoritesPage(),
            ),
            
            // Settings tab route
            GoRoute(
              path: '/settings',
              name: 'settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),

        // Routes that appear on top of the shell
        
        // Home route (accessible outside shell for backwards compatibility)
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),

        // Search route
        GoRoute(
          path: '/search',
          name: 'search',
          builder: (context, state) => const SearchPage(),
        ),

        // Detail route
        GoRoute(
          path: '/detail',
          name: 'detail',
          builder: (context, state) {
            final content = state.extra as Content?;
            if (content == null) {
              // Redirect to home if no content provided
              return const HomePage();
            }
            return DetailPage(content: content);
          },
        ),
      ],
      errorBuilder: (context, state) =>
          _ErrorPage(error: state.error?.toString() ?? 'Unknown error'),
    );
  }
}

/// Error page for route errors
class _ErrorPage extends StatelessWidget {
  final String error;

  const _ErrorPage({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              const SizedBox(height: 16),
              Text(
                'Page Not Found',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'The page you requested could not be found.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/anime'),
                child: const Text('Go to Anime'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Placeholder page for routes not yet implemented
class _PlaceholderPage extends StatelessWidget {
  final String title;
  final String message;

  const _PlaceholderPage({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.construction, size: 64, color: Colors.orange[300]),
              const SizedBox(height: 16),
              Text(
                'Coming Soon',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Error page for route errors
class _ErrorPageGoHome extends StatelessWidget {
  final String error;

  const _ErrorPageGoHome({required this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error'), centerTitle: true),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
              const SizedBox(height: 16),
              Text(
                'Page Not Found',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'The page you requested could not be found.',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
