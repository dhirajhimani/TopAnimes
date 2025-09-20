import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:top_anime/domain/entities/content.dart';
import 'package:top_anime/features/detail/presentation/pages/detail_page.dart';
import 'package:top_anime/features/home/presentation/pages/home_page.dart';
import 'package:top_anime/features/search/presentation/pages/search_page.dart';

/// Application routes configuration
class AppRouter {
  /// Creates the router configuration
  static GoRouter createRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        // Home route
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

        // Light novels route (placeholder for future implementation)
        GoRoute(
          path: '/light-novels',
          name: 'light-novels',
          builder: (context, state) => const _PlaceholderPage(
            title: 'Light Novels',
            message: 'Light novel browser coming soon!',
          ),
        ),

        // Anime list route (placeholder)
        GoRoute(
          path: '/anime',
          name: 'anime',
          builder: (context, state) => const _PlaceholderPage(
            title: 'All Anime',
            message: 'Full anime list coming soon!',
          ),
        ),

        // Manga list route (placeholder)
        GoRoute(
          path: '/manga',
          name: 'manga',
          builder: (context, state) => const _PlaceholderPage(
            title: 'All Manga',
            message: 'Full manga list coming soon!',
          ),
        ),
      ],
      errorBuilder: (context, state) =>
          _ErrorPage(error: state.error?.toString() ?? 'Unknown error'),
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
