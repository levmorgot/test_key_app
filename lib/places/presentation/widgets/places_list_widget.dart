import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:key_test_project/common/widgets/empty_message.dart';
import 'package:key_test_project/common/widgets/progress_indicator.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';
import 'package:key_test_project/places/presentation/bloc/bookings_cubit/bookings_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/place_select_cubit/place_select_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/places_list_cubit/places_list_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/places_list_cubit/places_list_state.dart';
import 'package:key_test_project/places/presentation/widgets/places_card_widget.dart';
import 'package:key_test_project/places/presentation/widgets/select_btn_widget.dart';

class PlacesList extends StatelessWidget {
  final int officeId;

  const PlacesList({
    Key? key,
    required this.officeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<PlacesListCubit>().loadPlaces(officeId);
    context.read<BookingsCubit>().loadAllBookings();
    context.read<PlaceSelectCubit>().clearPlace();
    return BlocBuilder<PlacesListCubit, PlaceState>(builder: (context, state) {
      List<PlaceEntity> places = [];
      if (state is PlaceLoadingState) {
        return _loadingIndicator();
      } else if (state is PlaceErrorState) {
        return Text(state.message);
      } else if (state is PlaceEmptyState) {
        return const EmptyMessage(message: 'Нам очень жаль, но офис пустой');
      } else if (state is PlaceLoadedState) {
        places = state.placesList['$officeId'] ?? [];
      }
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              'assets/office.svg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          ..._getPlaces(places),
          const SelectBtn(),
        ],
      );
    });
  }

  List<Widget> _getPlaces(List<PlaceEntity> places) {
    List<Widget> placesWidgets = [];
    for (int i = 0; i < places.length; i++) {
      placesWidgets.add(
        PlaceCard(index: i, place: places[i], officeId: officeId,),
      );
    }
    return placesWidgets;
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
