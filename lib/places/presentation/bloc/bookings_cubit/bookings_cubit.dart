import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';
import 'package:key_test_project/places/domain/usecases/add_booking.dart';
import 'package:key_test_project/places/domain/usecases/get_all_bookings.dart';
import 'package:key_test_project/places/domain/usecases/params/booking_params.dart';
import 'package:key_test_project/places/presentation/bloc/bookings_cubit/bookings_state.dart';

class BookingsCubit extends Cubit<BookingState> {
  final GetAllBookings getAllBookings;
  final AddBooking addBooking;

  BookingsCubit({
    required this.addBooking,
    required this.getAllBookings,
  }) : super(BookingEmptyState());

    void loadAllBookings() async {
    if (state is BookingLoadingState) return;

    emit(BookingLoadingState());

    final failureOrBookings = await getAllBookings(null);

    failureOrBookings.fold(
            (failure) =>
            emit(BookingErrorState(message: _mapFailureMessage(failure))),
            (bookings) {
              bookings.sort((a, b) => b.timestamp.compareTo(a.timestamp));
          emit(bookings.isNotEmpty
              ? BookingLoadedState({'all':bookings})
              : BookingEmptyState());
        });
  }

  void bookingPlace(PlaceEntity place) async {
    if (state is BookingLoadingState) return;

    var currentState = state;

    emit(BookingLoadingState());

    final failureOrNewBooking = await addBooking(BookingParams(
      place: place,
    ));

    failureOrNewBooking.fold(
        (failure) =>
            emit(BookingErrorState(message: _mapFailureMessage(failure))),
        (newBooking) {
      var oldBookings = (currentState as BookingLoadedState).bookingsList;
      oldBookings['${place.id}']?.add(newBooking);
      emit(BookingLoadedState(oldBookings));
    });
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server failure';
      case CacheFailure:
        return 'Cache failure';
      default:
        return 'Unexpected Error';
    }
  }
}
