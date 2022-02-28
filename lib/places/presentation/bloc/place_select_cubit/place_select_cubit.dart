import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';
import 'package:key_test_project/places/presentation/bloc/place_select_cubit/place_select_state.dart';
import 'package:key_test_project/places/presentation/bloc/places_list_cubit/places_list_state.dart';

class PlaceSelectCubit extends Cubit<PlaceSelectState> {

  PlaceSelectCubit() : super(PlaceSelectEmptyState());

  void selectPlace(PlaceEntity place) async {
    if (state is PlaceLoadingState) return;

    emit(PlaceSelectLoadingState());

    emit(PlaceSelectedState(place));
  }

  void clearPlace() async {
    if (state is PlaceLoadingState) return;

    emit(PlaceSelectLoadingState());

    emit(PlaceSelectEmptyState());
  }

}
