import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/offices/domain/entities/office_entity.dart';
import 'package:key_test_project/offices/domain/usecases/get_all_offices.dart';
import 'package:key_test_project/offices/presentation/bloc/offices_list_cubit/offices_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfficesListCubit extends Cubit<OfficeState> {
  final GetAllOffices getAllOffices;

  OfficesListCubit({required this.getAllOffices})
      : super(OfficeEmptyState());

  void loadOffices() async {
    if (state is OfficeLoadingState) return;

    final currentState = state;

    var oldOffices = <OfficeEntity>[];
    if (currentState is OfficeLoadedState) {
      oldOffices = currentState.officesList;
    }

    emit(OfficeLoadingState(oldOffices));

    final failureOrOffices =
        await getAllOffices(null);

    failureOrOffices.fold(
        (failure) =>
            emit(OfficeErrorState(message: _mapFailureMessage(failure))),
        (office) {
      final offices = (state as OfficeLoadingState).oldOfficesList;
      offices.addAll(office);
      emit(OfficeLoadedState(offices, office.isEmpty));
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
