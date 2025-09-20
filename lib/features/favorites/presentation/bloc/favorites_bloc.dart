import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/favorite_content.dart';
import '../../domain/usecases/add_to_favorites.dart';
import '../../domain/usecases/get_favorites.dart';
import '../../domain/usecases/is_favorite.dart';
import '../../domain/usecases/remove_from_favorites.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

/// BLoC for managing favorites state
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  /// Use case for getting favorites
  final GetFavorites getFavorites;
  
  /// Use case for adding to favorites
  final AddToFavorites addToFavorites;
  
  /// Use case for removing from favorites
  final RemoveFromFavorites removeFromFavorites;
  
  /// Use case for checking if content is favorite
  final IsFavorite isFavorite;
  
  /// Creates a [FavoritesBloc]
  FavoritesBloc({
    required this.getFavorites,
    required this.addToFavorites,
    required this.removeFromFavorites,
    required this.isFavorite,
  }) : super(const FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddToFavoritesEvent>(_onAddToFavorites);
    on<RemoveFromFavoritesEvent>(_onRemoveFromFavorites);
    on<CheckIsFavorite>(_onCheckIsFavorite);
    on<ClearAllFavorites>(_onClearAllFavorites);
  }
  
  /// Handles loading favorites
  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());
    
    final result = await getFavorites(NoParams());
    
    result.fold(
      (failure) => emit(FavoritesError(message: failure.message)),
      (favorites) {
        final favoriteStatus = <int, bool>{};
        for (final fav in favorites) {
          favoriteStatus[fav.id] = true;
        }
        emit(FavoritesLoaded(
          favorites: favorites,
          favoriteStatus: favoriteStatus,
        ));
      },
    );
  }
  
  /// Handles adding to favorites
  Future<void> _onAddToFavorites(
    AddToFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      emit(FavoritesOperationInProgress(
        favorites: currentState.favorites,
        favoriteStatus: currentState.favoriteStatus,
        operation: 'Adding to favorites...',
      ));
      
      final favoriteContent = FavoriteContent.fromContent(event.content);
      final result = await addToFavorites(AddToFavoritesParams(favoriteContent));
      
      result.fold(
        (failure) => emit(FavoritesError(
          message: failure.message,
          favorites: currentState.favorites,
          favoriteStatus: currentState.favoriteStatus,
        )),
        (_) {
          final updatedFavorites = List<FavoriteContent>.from(currentState.favorites)
            ..insert(0, favoriteContent); // Add at the beginning
          final updatedStatus = Map<int, bool>.from(currentState.favoriteStatus)
            ..[event.content.id] = true;
          
          emit(FavoritesLoaded(
            favorites: updatedFavorites,
            favoriteStatus: updatedStatus,
          ));
        },
      );
    }
  }
  
  /// Handles removing from favorites
  Future<void> _onRemoveFromFavorites(
    RemoveFromFavoritesEvent event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      emit(FavoritesOperationInProgress(
        favorites: currentState.favorites,
        favoriteStatus: currentState.favoriteStatus,
        operation: 'Removing from favorites...',
      ));
      
      final result = await removeFromFavorites(RemoveFromFavoritesParams(event.contentId));
      
      result.fold(
        (failure) => emit(FavoritesError(
          message: failure.message,
          favorites: currentState.favorites,
          favoriteStatus: currentState.favoriteStatus,
        )),
        (_) {
          final updatedFavorites = currentState.favorites
              .where((fav) => fav.id != event.contentId)
              .toList();
          final updatedStatus = Map<int, bool>.from(currentState.favoriteStatus)
            ..remove(event.contentId);
          
          emit(FavoritesLoaded(
            favorites: updatedFavorites,
            favoriteStatus: updatedStatus,
          ));
        },
      );
    }
  }
  
  /// Handles checking if content is favorite
  Future<void> _onCheckIsFavorite(
    CheckIsFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    final result = await isFavorite(IsFavoriteParams(event.contentId));
    
    result.fold(
      (failure) {
        // Don't emit error for single checks, just update the status
        if (state is FavoritesLoaded) {
          final currentState = state as FavoritesLoaded;
          final updatedStatus = Map<int, bool>.from(currentState.favoriteStatus)
            ..[event.contentId] = false;
          
          emit(currentState.copyWith(favoriteStatus: updatedStatus));
        }
      },
      (isCurrentlyFavorite) {
        if (state is FavoritesLoaded) {
          final currentState = state as FavoritesLoaded;
          final updatedStatus = Map<int, bool>.from(currentState.favoriteStatus)
            ..[event.contentId] = isCurrentlyFavorite;
          
          emit(currentState.copyWith(favoriteStatus: updatedStatus));
        }
      },
    );
  }
  
  /// Handles clearing all favorites
  Future<void> _onClearAllFavorites(
    ClearAllFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final currentState = state;
    if (currentState is FavoritesLoaded) {
      emit(FavoritesOperationInProgress(
        favorites: currentState.favorites,
        favoriteStatus: currentState.favoriteStatus,
        operation: 'Clearing all favorites...',
      ));
      
      // Note: This would need to be implemented in the use cases
      // For now, we'll emit the loaded state with empty data
      emit(const FavoritesLoaded(
        favorites: [],
        favoriteStatus: {},
      ));
    }
  }
}