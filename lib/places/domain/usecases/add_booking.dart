import 'package:dartz/dartz.dart';
import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/core/usecases/usecase.dart';
import 'package:key_test_project/places/domain/entities/booking_entity.dart';
import 'package:key_test_project/places/domain/repositories/booking_repository.dart';
import 'package:key_test_project/places/domain/usecases/params/booking_params.dart';

class AddBooking extends UseCase<BookingEntity, BookingParams> {
  final IBookingRepository bookingRepository;

  AddBooking(this.bookingRepository);

  @override
  Future<Either<Failure, BookingEntity>> call(
      BookingParams params) async {
    return await bookingRepository.addBooking(params.place);
  }
}
