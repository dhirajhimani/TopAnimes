import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/anime.dart';
import '../../../../domain/entities/content.dart';
import '../../../../domain/entities/manga.dart';
import 'search_event.dart';
import 'search_state.dart';

/// BLoC for managing search functionality
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  Timer? _debounceTimer;
  
  /// Creates a [SearchBloc]
  SearchBloc() : super(const SearchInitial()) {
    on<SearchContent>(_onSearchContent);
    on<ClearSearch>(_onClearSearch);
  }
  
  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
  
  /// Handles content search with debouncing
  Future<void> _onSearchContent(
    SearchContent event,
    Emitter<SearchState> emit,
  ) async {
    // Cancel previous timer
    _debounceTimer?.cancel();
    
    // If query is empty, return to initial state
    if (event.query.trim().isEmpty) {
      emit(const SearchInitial());
      return;
    }
    
    // Debounce the search
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      _performSearch(event.query.trim(), emit);
    });
  }
  
  /// Performs the actual search
  Future<void> _performSearch(String query, Emitter<SearchState> emit) async {
    emit(SearchLoading(query));
    
    try {
      // Simulate API calls - in a real app, these would be actual API calls
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Mock search results
      final results = <ContentType, List<Content>>{};
      
      // Mock anime results
      if (query.toLowerCase().contains('anime') || query.toLowerCase().contains('attack')) {
        results[ContentType.anime] = [
          Content.fromAnime(const Anime(
            id: 1,
            title: 'Attack on Titan',
            url: 'https://myanimelist.net/anime/16498',
            imageUrl: 'https://cdn.myanimelist.net/images/anime/10/47347.jpg',
            synopsis: 'Humanity fights for survival against the Titans.',
            score: 9.0,
            status: 'Finished Airing',
            episodes: 25,
            members: 3000000,
          )),
        ];
      }
      
      // Mock manga results
      if (query.toLowerCase().contains('manga') || query.toLowerCase().contains('one piece')) {
        results[ContentType.manga] = [
          Content.fromManga(const Manga(
            id: 1,
            title: 'One Piece',
            url: 'https://myanimelist.net/manga/13',
            imageUrl: 'https://cdn.myanimelist.net/images/manga/2/253146.jpg',
            synopsis: 'The story of Monkey D. Luffy and his pirate crew.',
            score: 9.2,
            status: 'Publishing',
            chapters: 1100,
            volumes: 105,
            members: 2500000,
          )),
        ];
      }
      
      // Mock light novel results
      if (query.toLowerCase().contains('light') || query.toLowerCase().contains('novel')) {
        results[ContentType.lightNovel] = [
          // Mock light novel - would come from RanobeDB API
          const Content(
            type: ContentType.lightNovel,
            id: 1,
            title: 'Sword Art Online',
            url: 'https://ranobedb.org/novel/1',
            imageUrl: 'https://ranobedb.org/covers/1.jpg',
            synopsis: 'Players trapped in a virtual reality MMORPG.',
            status: 'Completed',
            members: 0,
            metadata: {
              'volumes': 25,
              'authors': ['Reki Kawahara'],
              'language': 'Japanese',
            },
          ),
        ];
      }
      
      emit(SearchLoaded(
        query: query,
        results: results,
      ));
    } catch (e) {
      emit(SearchError(
        query: query,
        message: 'Failed to search: ${e.toString()}',
      ));
    }
  }
  
  /// Handles clearing search results
  void _onClearSearch(ClearSearch event, Emitter<SearchState> emit) {
    _debounceTimer?.cancel();
    emit(const SearchInitial());
  }
}