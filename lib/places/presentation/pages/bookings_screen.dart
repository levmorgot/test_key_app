import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_test_project/common/app_colors.dart';
import 'package:key_test_project/common/widgets/progress_indicator.dart';
import 'package:key_test_project/places/domain/entities/booking_entity.dart';
import 'package:key_test_project/places/presentation/bloc/bookings_cubit/bookings_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/bookings_cubit/bookings_state.dart';
import 'package:key_test_project/places/presentation/widgets/booking_card_widget.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<BookingsCubit>().loadAllBookings();
    return Scaffold(
      appBar: AppBar(
        title: const Text('История бронирований'),
        centerTitle: true,
      ),
      body: BlocBuilder<BookingsCubit, BookingState>(builder: (context, state) {
        List<BookingEntity> bookings = [];
        if (state is BookingLoadingState) {
          return _loadingIndicator();
        } else if (state is BookingErrorState) {
          return Text(
            state.message,
            style:
                const TextStyle(fontSize: 20, color: AppColors.officeCardText),
          );
        }  else if (state is BookingLoadedState) {
          bookings = state.bookingsList['all'] ?? [];
        }
        return ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: BookingCard(booking: bookings[index]),
            );
          },
          itemCount: bookings.length,
        );
      }),
    );
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
