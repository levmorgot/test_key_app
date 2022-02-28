import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:key_test_project/bloc/navbar_cubit/navbar_cubit.dart';
import 'package:key_test_project/common/app_colors.dart';
import 'package:key_test_project/offices/presentation/bloc/offices_list_cubit/offices_list_cubit.dart';
import 'package:key_test_project/offices/presentation/pages/offices_screen.dart';
import 'package:key_test_project/locator_service.dart' as di;
import 'package:key_test_project/locator_service.dart';
import 'package:key_test_project/places/presentation/bloc/bookings_cubit/bookings_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/place_select_cubit/place_select_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/places_list_cubit/places_list_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<OfficesListCubit>(
              create: (context) => sl<OfficesListCubit>()..loadOffices()),
          BlocProvider<NavbarCubit>(
              create: (context) => sl<NavbarCubit>()),
          BlocProvider<PlacesListCubit>(
              create: (context) => sl<PlacesListCubit>()),
          BlocProvider<PlaceSelectCubit>(
              create: (context) => sl<PlaceSelectCubit>()),
          BlocProvider<BookingsCubit>(
              create: (context) => sl<BookingsCubit>()),
        ],
        child: MaterialApp(

          // locale: const Locale('ru'),
          theme: ThemeData.dark().copyWith(
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.appBarBackground,
            ),
            backgroundColor: AppColors.mainBackground,
            scaffoldBackgroundColor: AppColors.mainBackground,
          ),
          home: HomePage(),
        ));
  }
}
