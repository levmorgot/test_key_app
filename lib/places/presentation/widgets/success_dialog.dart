import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_test_project/bloc/navbar_cubit/navbar_cubit.dart';
import 'package:key_test_project/common/app_colors.dart';
import 'package:key_test_project/places/presentation/bloc/bookings_cubit/bookings_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/place_select_cubit/place_select_cubit.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: AppColors.mainBackground,
      title: const Text(
        'Бронирование успешно!',
        style: TextStyle(color: AppColors.officeCardText),
      ),
      children: [
        const Divider(
          height: 2,
          color: AppColors.cardDivider,
        ),
        TextButton(
          onPressed: () {
            context.read<PlaceSelectCubit>().clearPlace();
            context.read<BookingsCubit>().loadAllBookings();
            Navigator.of(context).pop();
          },
          child: const Center(
            child: Text('Забронировать ещё'),
          ),
        ),
        const Divider(
          height: 2,
          color: AppColors.cardDivider,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<NavbarCubit>().selectTab(1);
          },
          child: const Center(
            child: Text('Завершить'),
          ),
        ),
      ],
    );
  }
}
