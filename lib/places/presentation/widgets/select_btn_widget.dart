import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_test_project/common/app_colors.dart';
import 'package:key_test_project/places/presentation/bloc/bookings_cubit/bookings_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/place_select_cubit/place_select_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/place_select_cubit/place_select_state.dart';
import 'package:key_test_project/places/presentation/widgets/success_dialog.dart';

class SelectBtn extends StatelessWidget {
  const SelectBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaceSelectCubit, PlaceSelectState>(
        builder: (context, state) {
      return TextButton(
        onPressed: state is PlaceSelectedState
            ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    context.read<BookingsCubit>().bookingPlace(state.place);
                    return const SuccessDialog();
                  },
                );
              }
            : () {},
        child: SizedBox(
          height: 30,
          width: 300,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: state is PlaceSelectedState
                  ? AppColors.selectedBtn
                  : AppColors.selectBtn,
            ),
            child: Center(
              child: Text(
                state is PlaceSelectedState
                    ? 'Подтвердить'
                    : 'Укажите место на карте...',
                style: const TextStyle(color: AppColors.selectBtnText),
              ),
            ),
          ),
        ),
      );
    });
  }
}
