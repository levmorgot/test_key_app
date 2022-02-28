import 'package:dartz/dartz.dart';
import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/core/usecases/usecase.dart';
import 'package:key_test_project/places/domain/entities/booking_entity.dart';
import 'package:key_test_project/places/domain/repositories/booking_repository.dart';

class GetAllBookings extends UseCase<List<BookingEntity>, void> {
  final IBookingRepository bookingRepository;

  GetAllBookings(this.bookingRepository);

  @override
  Future<Either<Failure, List<BookingEntity>>> call(
      void params) async {
    return await bookingRepository.getAllBookings();
  }
}
