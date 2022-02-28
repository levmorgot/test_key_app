import 'package:dartz/dartz.dart';
import 'package:key_test_project/core/error/exception.dart';
import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/places/data/datasources/booking_local_data_sources.dart';
import 'package:key_test_project/places/data/datasources/booking_remote_data_sources.dart';
import 'package:key_test_project/places/domain/entities/booking_entity.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';
import 'package:key_test_project/places/domain/repositories/booking_repository.dart';

class BookingRepository implements IBookingRepository {
  final IBookingRemoteDataSource remoteDataSource;
  final IBookingLocalDataSource localDataSource;

  BookingRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, BookingEntity>> addBooking(PlaceEntity place) async {
    try {
      var newBooking = await remoteDataSource.addBooking(place);
      var localBookings = await localDataSource.getBookingsForOfficeFromCache(
          place.office.id); // localDataSource нужен только для теста
      localBookings.add(newBooking); // localBookings нужен только для теста
      await localDataSource.bookingToCache(localBookings,
          place.office.id); // localDataSource нужен только для теста
      return Right(newBooking);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<BookingEntity>>> getAllBookings() async {
    try {
      var remoteBookings = await remoteDataSource.getAllBookings();
      final localBookings = await localDataSource
          .getAllBookingsFromCache(); // localDataSource нужен только для теста
      remoteBookings.addAll(localBookings);
      return Right(remoteBookings);
    } on ServerException {
      return Left(ServerFailure());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
