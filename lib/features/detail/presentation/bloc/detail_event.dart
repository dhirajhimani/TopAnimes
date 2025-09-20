import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../domain/entities/content.dart';

/// Base class for all detail events
abstract class DetailEvent extends Equatable {
  const DetailEvent();
  
  @override
  List<Object?> get props => [];
}

/// Event to load detailed information for content
class LoadContentDetail extends DetailEvent {
  /// Content to load details for
  final Content content;
  
  const LoadContentDetail(this.content);
  
  @override
  List<Object?> get props => [content];
}

/// Event to refresh content details
class RefreshContentDetail extends DetailEvent {
  /// Content to refresh details for
  final Content content;
  
  const RefreshContentDetail(this.content);
  
  @override
  List<Object?> get props => [content];
}

/// Event to extract dominant color from content image
class ExtractDominantColor extends DetailEvent {
  /// Content to extract color for
  final Content content;
  
  const ExtractDominantColor(this.content);
  
  @override
  List<Object?> get props => [content];
}

/// Event to toggle favorite status
class ToggleFavorite extends DetailEvent {
  /// Content to toggle favorite for
  final Content content;
  
  const ToggleFavorite(this.content);
  
  @override
  List<Object?> get props => [content];
}

/// Event when dominant color is extracted
class DominantColorExtracted extends DetailEvent {
  /// Extracted dominant color
  final Color dominantColor;
  
  const DominantColorExtracted(this.dominantColor);
  
  @override
  List<Object?> get props => [dominantColor];
}