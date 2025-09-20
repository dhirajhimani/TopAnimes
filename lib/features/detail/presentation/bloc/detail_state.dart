import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../domain/entities/content.dart';

/// Base class for all detail states
abstract class DetailState extends Equatable {
  const DetailState();
  
  @override
  List<Object?> get props => [];
}

/// Initial state when the detail screen is first loaded
class DetailInitial extends DetailState {
  const DetailInitial();
}

/// State when detail data is being loaded
class DetailLoading extends DetailState {
  /// Content being loaded
  final Content content;
  
  const DetailLoading(this.content);
  
  @override
  List<Object?> get props => [content];
}

/// State when detail data has been successfully loaded
class DetailLoaded extends DetailState {
  /// Content with full details
  final Content content;
  
  /// Dynamic color extracted from the content's image
  final Color? dominantColor;
  
  /// Whether this content is in favorites
  final bool isFavorite;
  
  /// Creates a [DetailLoaded] state
  const DetailLoaded({
    required this.content,
    this.dominantColor,
    this.isFavorite = false,
  });
  
  @override
  List<Object?> get props => [content, dominantColor, isFavorite];
  
  /// Creates a copy with updated values
  DetailLoaded copyWith({
    Content? content,
    Color? dominantColor,
    bool? isFavorite,
  }) {
    return DetailLoaded(
      content: content ?? this.content,
      dominantColor: dominantColor ?? this.dominantColor,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

/// State when an error occurred while loading detail data
class DetailError extends DetailState {
  /// Content that failed to load
  final Content content;
  
  /// Error message describing what went wrong
  final String message;
  
  /// Creates a [DetailError] state
  const DetailError({
    required this.content,
    required this.message,
  });
  
  @override
  List<Object?> get props => [content, message];
}