import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_test_project/common/app_colors.dart';
import 'package:key_test_project/common/widgets/progress_indicator.dart';
import 'package:key_test_project/places/domain/entities/booking_entity.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';
import 'package:key_test_project/places/presentation/bloc/bookings_cubit/bookings_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/bookings_cubit/bookings_state.dart';
import 'package:key_test_project/places/presentation/bloc/place_select_cubit/place_select_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/place_select_cubit/place_select_state.dart';

class PlaceCard extends StatelessWidget {
  final PlaceEntity place;
  final int index;
  final int officeId;

  const PlaceCard(
      {Key? key,
      required this.place,
      required this.index,
      required this.officeId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsCubit, BookingState>(builder: (context, state) {
      return Positioned(
        top: index < 2
            ? MediaQuery.of(context).size.height / 4.5 * 1.3 +
                index * (MediaQuery.of(context).size.height / 5 + 10)
            : MediaQuery.of(context).size.height / 4.5 / 3 +
                (index - 2) * (MediaQuery.of(context).size.height / 5 + 10),
        left: index < 2 ? 30 : 260,
        child: Builder(builder: (context) {
          List<BookingEntity> bookings = [];
          bool isBooking = false;
          bool isMyBooking = false;
          if (state is BookingLoadingState) {
            return _loadingIndicator();
          } else if (state is BookingErrorState) {
            return Text(
              state.message,
              style: const TextStyle(
                  fontSize: 20, color: AppColors.officeCardText),
            );
          } else if (state is BookingLoadedState) {
            bookings = state.bookingsList['all'] ?? [];
            bookings = bookings.isNotEmpty ? bookings.where((booking) {
              DateTime bookingDate = DateTime.fromMillisecondsSinceEpoch(booking.timestamp);
              DateTime today = DateTime.now();
              return today.difference(bookingDate).inDays == 0;
            }).toList() : [];
            isBooking =
                bookings.where((booking) => booking.place == place).isNotEmpty;
            isMyBooking = bookings
                .where(
                    (booking) => booking.place == place && booking.isMyBooking)
                .isNotEmpty;
          }
          return GestureDetector(
            onTap: !isMyBooking && !isBooking
                ? () {
                    context.read<PlaceSelectCubit>().selectPlace(place);
                  }
                : () {},
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width / 4.5,
              child: BlocBuilder<PlaceSelectCubit, PlaceSelectState>(
                  builder: (context, state) {
                bool isSelected = false;
                if (state is PlaceSelectLoadingState) {
                  return _loadingIndicator();
                } else if (state is PlaceSelectedState) {
                  isSelected = place.id == state.place.id;
                }
                return DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: isSelected
                        ? AppColors.selectedPlace
                        : isMyBooking
                            ? AppColors.myBookingPlace
                            : isBooking
                                ? AppColors.bookingPlace
                                : AppColors.freePlace,
                  ),
                  child: const SizedBox(),
                );
              }),
            ),
          );
        }),
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: AppProgressIndicator(),
      ),
    );
  }
}
