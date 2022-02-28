import 'package:equatable/equatable.dart';
import 'package:key_test_project/places/domain/entities/booking_entity.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingEmptyState extends BookingState {
  @override
  List<Object> get props => [];
}

class BookingLoadingState extends BookingState {
  @override
  List<Object> get props => [];
}


class BookingLoadedState extends BookingState {
  final Map<String, List<BookingEntity>> bookingsList;

  const BookingLoadedState(this.bookingsList);

  @override
  List<Object> get props => [bookingsList];
}


class BookingErrorState extends BookingState {
  final String message;

  const BookingErrorState({required this.message});

  @override
  List<Object> get props => [message];
}