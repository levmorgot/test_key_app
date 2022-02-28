import 'package:equatable/equatable.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';

abstract class PlaceSelectState extends Equatable {
  const PlaceSelectState();

  @override
  List<Object> get props => [];
}

class PlaceSelectEmptyState extends PlaceSelectState {
  @override
  List<Object> get props => [];
}

class PlaceSelectLoadingState extends PlaceSelectState {
  @override
  List<Object> get props => [];
}

class PlaceSelectedState extends PlaceSelectState {
  final PlaceEntity place;

  const PlaceSelectedState(this.place);

  @override
  List<Object> get props => [place];
}


