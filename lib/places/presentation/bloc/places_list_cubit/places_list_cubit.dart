import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/places/domain/usecases/get_all_places.dart';
import 'package:key_test_project/places/domain/usecases/params/place_params.dart';
import 'package:key_test_project/places/presentation/bloc/places_list_cubit/places_list_state.dart';

class PlacesListCubit extends Cubit<PlaceState> {
  final GetAllPlaces getAllPlaces;

  PlacesListCubit({
    required this.getAllPlaces,
  }) : super(PlaceEmptyState());

  void loadPlaces(int officeId) async {
    if (state is PlaceLoadingState) return;

    emit(PlaceLoadingState());

    final failureOrPlaces = await getAllPlaces(PlaceParams(
      officeId: officeId,
    ));

    failureOrPlaces.fold(
        (failure) =>
            emit(PlaceErrorState(message: _mapFailureMessage(failure))),
        (places) {

      emit(places.isNotEmpty
          ? PlaceLoadedState(
              {'$officeId': places})
          : PlaceEmptyState());
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
