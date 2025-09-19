import 'package:equatable/equatable.dart';
import '../../../../domain/entities/content.dart';

/// Base class for all detail events
abstract class DetailEvent extends Equatable {
  const DetailEvent();
  
  @override
  List<Object> get props => [];
}

/// Event to load detailed information for content
class LoadContentDetail extends DetailEvent {
  /// Content to load details for
  final Content content;
  
  const LoadContentDetail(this.content);
  
  @override
  List<Object> get props => [content];
}

/// Event to refresh content details
class RefreshContentDetail extends DetailEvent {
  /// Content to refresh details for
  final Content content;
  
  const RefreshContentDetail(this.content);
  
  @override
  List<Object> get props => [content];
}