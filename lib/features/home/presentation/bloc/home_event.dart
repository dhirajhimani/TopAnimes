import 'package:equatable/equatable.dart';

/// Base class for all home events
abstract class HomeEvent extends Equatable {
  const HomeEvent();
  
  @override
  List<Object> get props => [];
}

/// Event to load home screen data
class LoadHomeData extends HomeEvent {
  const LoadHomeData();
}

/// Event to refresh home screen data
class RefreshHomeData extends HomeEvent {
  const RefreshHomeData();
}