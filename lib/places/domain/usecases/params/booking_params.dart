import 'package:equatable/equatable.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';

class BookingParams extends Equatable {
  final PlaceEntity place;

  const BookingParams({
    required this.place,
  });


  @override
  List<Object?> get props => [place];
}