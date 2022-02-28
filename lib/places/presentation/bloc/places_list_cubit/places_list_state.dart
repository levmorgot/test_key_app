import 'package:key_test_project/places/domain/entities/place_entity.dart';
import 'package:equatable/equatable.dart';

abstract class PlaceState extends Equatable {
  const PlaceState();

  @override
  List<Object> get props => [];
}

class PlaceEmptyState extends PlaceState {
  @override
  List<Object> get props => [];
}

class PlaceLoadingState extends PlaceState {
  @override
  List<Object> get props => [];
}


class PlaceLoadedState extends PlaceState {
  final Map<String, List<PlaceEntity>> placesList;

  const PlaceLoadedState(this.placesList);

  @override
  List<Object> get props => [placesList];
}


class PlaceErrorState extends PlaceState {
  final String message;

  const PlaceErrorState({required this.message});

  @override
  List<Object> get props => [message];
}