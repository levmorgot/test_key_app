import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_test_project/bloc/navbar_cubit/navbar_state.dart';
import 'package:key_test_project/places/presentation/bloc/places_list_cubit/places_list_state.dart';

class NavbarCubit extends Cubit<NavbarState> {

  NavbarCubit() : super(NavbarEmptyState());

  void selectTab(int tab) async {
    if (state is PlaceLoadingState) return;

    emit(NavbarLoadingState());

    emit(NavbarChangedState(tab));
  }

}
