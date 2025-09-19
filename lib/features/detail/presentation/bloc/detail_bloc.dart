import 'package:flutter_bloc/flutter_bloc.dart';
import 'detail_event.dart';
import 'detail_state.dart';

/// BLoC for managing detail screen state
class DetailBloc extends Bloc<DetailEvent, DetailState> {
  /// Creates a [DetailBloc]
  DetailBloc() : super(const DetailInitial()) {
    on<LoadContentDetail>(_onLoadContentDetail);
    on<RefreshContentDetail>(_onRefreshContentDetail);
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
      emit(DetailLoaded(event.content));
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
}