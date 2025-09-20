import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:http/http.dart' as http;
import '../../../favorites/presentation/bloc/favorites_bloc.dart';
import '../../../favorites/presentation/bloc/favorites_event.dart';
import 'detail_event.dart';
import 'detail_state.dart';

/// BLoC for managing detail screen state
class DetailBloc extends Bloc<DetailEvent, DetailState> {
  /// Optional favorites bloc for checking favorite status
  final FavoritesBloc? favoritesBloc;
  
  /// Creates a [DetailBloc]
  DetailBloc({this.favoritesBloc}) : super(const DetailInitial()) {
    on<LoadContentDetail>(_onLoadContentDetail);
    on<RefreshContentDetail>(_onRefreshContentDetail);
    on<ExtractDominantColor>(_onExtractDominantColor);
    on<ToggleFavorite>(_onToggleFavorite);
    on<DominantColorExtracted>(_onDominantColorExtracted);
  }
  
  /// Handles loading content details
  Future<void> _onLoadContentDetail(
    LoadContentDetail event,
    Emitter<DetailState> emit,
  ) async {
    emit(DetailLoading(event.content));
    
    try {
      // For now, we'll just use the content as-is since it already has
      // all the necessary information. In a real app, you might fetch
      // additional details from the API here.
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
      
      // Check favorite status
      bool isFavorite = false;
      if (favoritesBloc != null) {
        final favState = favoritesBloc!.state;
        if (favState is FavoritesLoaded) {
          isFavorite = favState.favoriteStatus[event.content.id] ?? false;
        }
      }
      
      emit(DetailLoaded(
        content: event.content,
        isFavorite: isFavorite,
      ));
      
      // Start extracting dominant color
      add(ExtractDominantColor(event.content));
      
    } catch (e) {
      emit(DetailError(
        content: event.content,
        message: 'Failed to load content details: ${e.toString()}',
      ));
    }
  }
  
  /// Handles refreshing content details
  Future<void> _onRefreshContentDetail(
    RefreshContentDetail event,
    Emitter<DetailState> emit,
  ) async {
    // For refresh, we just trigger the same logic as loading
    await _onLoadContentDetail(LoadContentDetail(event.content), emit);
  }
  
  /// Handles extracting dominant color from image
  Future<void> _onExtractDominantColor(
    ExtractDominantColor event,
    Emitter<DetailState> emit,
  ) async {
    try {
      // Download the image
      final response = await http.get(Uri.parse(event.content.imageUrl));
      if (response.statusCode == 200) {
        // Create image provider from bytes
        final Uint8List bytes = response.bodyBytes;
        final imageProvider = MemoryImage(bytes);
        
        // Generate palette
        final PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
          imageProvider,
          maximumColorCount: 20,
        );
        
        // Get dominant color
        Color? dominantColor = palette.dominantColor?.color ?? 
                              palette.vibrantColor?.color ?? 
                              palette.lightVibrantColor?.color ??
                              palette.darkVibrantColor?.color;
        
        if (dominantColor != null) {
          add(DominantColorExtracted(dominantColor));
        }
      }
    } catch (e) {
      // If color extraction fails, just continue without it
      debugPrint('Failed to extract dominant color: $e');
    }
  }
  
  /// Handles when dominant color is extracted
  Future<void> _onDominantColorExtracted(
    DominantColorExtracted event,
    Emitter<DetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is DetailLoaded) {
      emit(currentState.copyWith(dominantColor: event.dominantColor));
    }
  }
  
  /// Handles toggling favorite status
  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<DetailState> emit,
  ) async {
    final currentState = state;
    if (currentState is DetailLoaded && favoritesBloc != null) {
      if (currentState.isFavorite) {
        // Remove from favorites
        favoritesBloc!.add(RemoveFromFavoritesEvent(event.content.id));
        emit(currentState.copyWith(isFavorite: false));
      } else {
        // Add to favorites
        favoritesBloc!.add(AddToFavoritesEvent(event.content));
        emit(currentState.copyWith(isFavorite: true));
      }
    }
  }
}