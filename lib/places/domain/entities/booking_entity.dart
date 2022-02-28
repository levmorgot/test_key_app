import 'package:equatable/equatable.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';

class BookingEntity extends Equatable {
  final int id;
  final PlaceEntity place;
  final bool isMyBooking;
  final int timestamp;

  const BookingEntity({
    required this.id,
    required this.place,
    required this.isMyBooking,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, place, isMyBooking, timestamp];
}
