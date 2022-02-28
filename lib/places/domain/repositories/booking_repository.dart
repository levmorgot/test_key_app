import 'package:dartz/dartz.dart';
import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/places/domain/entities/booking_entity.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';

abstract class IBookingRepository {
  Future<Either<Failure, List<BookingEntity>>> getAllBookings();

  Future<Either<Failure, BookingEntity>> addBooking(PlaceEntity placeId);
}
