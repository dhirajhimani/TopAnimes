import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../domain/entities/content.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import '../widgets/search_result_item.dart';
import '../widgets/search_suggestions.dart';

/// Search screen for searching across all content types
class SearchPage extends StatefulWidget {
  /// Creates a [SearchPage]
  const SearchPage({super.key});
  
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;
  
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    
    // Auto-focus the search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _searchFocusNode.requestFocus();
    });
  }
  
  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Column(
              children: [
                _buildSearchBar(context),
                Expanded(
                  child: _buildContent(context, state),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
  
  /// Builds the app bar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Search'),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
    );
  }
  
  /// Builds the search bar
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        decoration: InputDecoration(
          hintText: 'Search anime, manga, or light novels...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    context.read<SearchBloc>().add(const ClearSearch());
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
        ),
        onChanged: (query) {
          context.read<SearchBloc>().add(SearchContent(query));
          setState(() {}); // Update to show/hide clear button
        },
        onSubmitted: (query) {
          context.read<SearchBloc>().add(SearchContent(query));
        },
      ),
    );
  }
  
  /// Builds the main content area
  Widget _buildContent(BuildContext context, SearchState state) {
    if (state is SearchInitial) {
      return SearchSuggestions(
        onSuggestionTap: (suggestion) {
          _searchController.text = suggestion;
          context.read<SearchBloc>().add(SearchContent(suggestion));
        },
      );
    } else if (state is SearchLoading) {
      return const _LoadingWidget();
    } else if (state is SearchLoaded) {
      return _buildSearchResults(context, state);
    } else if (state is SearchError) {
      return _ErrorWidget(
        message: state.message,
        onRetry: () {
          context.read<SearchBloc>().add(SearchContent(state.query));
        },
      );
    }
    
    return const SizedBox.shrink();
  }
  
  /// Builds the search results
  Widget _buildSearchResults(BuildContext context, SearchLoaded state) {
    if (state.totalResults == 0) {
      return _buildNoResults(state.query);
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Results summary
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              'Found ${state.totalResults} results for "${state.query}"',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          
          // Results by content type
          ...ContentType.values.map((type) {
            final results = state.getResultsForType(type);
            if (results.isEmpty) return const SizedBox.shrink();
            
            return _buildContentTypeSection(context, type, results);
          }),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }
  
  /// Builds a section for a specific content type
  Widget _buildContentTypeSection(
    BuildContext context,
    ContentType type,
    List<Content> results,
  ) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Icon(
                _getContentIcon(type),
                color: _getContentTypeColor(type),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${_getContentTypeLabel(type)} (${results.length})',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getContentTypeColor(type),
                ),
              ),
            ],
          ),
        ),
        
        // Results list
        ...results.map((content) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: SearchResultItem(
            content: content,
            onTap: () {
              context.go('/detail', extra: content);
            },
          ),
        )),
        
        const SizedBox(height: 16),
      ],
    );
  }
  
  /// Builds no results widget
  Widget _buildNoResults(String query) {
    final theme = Theme.of(context);
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No results found',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching for different keywords or check your spelling.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {
                _searchController.clear();
                context.read<SearchBloc>().add(const ClearSearch());
              },
              child: const Text('Clear Search'),
            ),
          ],
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
        return 'Light Novels';
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

/// Widget displayed while searching
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
          Text('Searching...'),
        ],
      ),
    );
  }
}

/// Widget displayed when search encounters an error
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
        padding: const EdgeInsets.all(32),
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
              'Search failed',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
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