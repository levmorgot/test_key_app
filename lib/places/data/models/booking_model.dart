
import 'package:key_test_project/places/data/models/place_model.dart';
import 'package:key_test_project/places/domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  const BookingModel({required id, required place, required isMyBooking, required timestamp})
      : super(id: id, place: place, isMyBooking: isMyBooking, timestamp: timestamp);

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'],
      place: PlaceModel.fromJson(json['place']),
      isMyBooking: json['isMyBooking'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'place': place,
      'isMyBooking': isMyBooking,
      'timestamp': timestamp,
    };
  }
}
