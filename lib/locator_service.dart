import 'package:get_it/get_it.dart';
import 'package:key_test_project/bloc/navbar_cubit/navbar_cubit.dart';
import 'package:key_test_project/offices/data/datasources/office_local_data_sources.dart';
import 'package:key_test_project/offices/data/datasources/office_remote_data_sources.dart';
import 'package:key_test_project/offices/data/repositories/office_repository.dart';
import 'package:key_test_project/offices/domain/repositories/office_repository.dart';
import 'package:key_test_project/offices/domain/usecases/get_all_offices.dart';
import 'package:key_test_project/offices/presentation/bloc/offices_list_cubit/offices_list_cubit.dart';
import 'package:key_test_project/places/data/datasources/booking_local_data_sources.dart';
import 'package:key_test_project/places/data/datasources/booking_remote_data_sources.dart';
import 'package:key_test_project/places/data/datasources/place_remote_data_sources.dart';
import 'package:key_test_project/places/data/repositories/booking_repository.dart';
import 'package:key_test_project/places/data/repositories/place_repository.dart';
import 'package:key_test_project/places/domain/repositories/booking_repository.dart';
import 'package:key_test_project/places/domain/repositories/place_repository.dart';
import 'package:key_test_project/places/domain/usecases/add_booking.dart';
import 'package:key_test_project/places/domain/usecases/get_all_bookings.dart';
import 'package:key_test_project/places/domain/usecases/get_all_places.dart';
import 'package:key_test_project/places/presentation/bloc/bookings_cubit/bookings_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/place_select_cubit/place_select_cubit.dart';
import 'package:key_test_project/places/presentation/bloc/places_list_cubit/places_list_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BloC / Cubit
  sl.registerFactory(
        () => NavbarCubit(),
  );

  sl.registerFactory(
    () => OfficesListCubit(getAllOffices: sl()),
  );

  sl.registerFactory(
    () => PlacesListCubit(getAllPlaces: sl()),
  );

  sl.registerFactory(
    () => PlaceSelectCubit(),
  );

  sl.registerFactory(
    () => BookingsCubit(addBooking: sl(), getAllBookings: sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => GetAllOffices(sl()));

  sl.registerLazySingleton(() => GetAllPlaces(sl()));

  sl.registerLazySingleton(() => GetAllBookings(sl()));
  sl.registerLazySingleton(() => AddBooking(sl()));

  // Repository office
  sl.registerLazySingleton<IOfficeRepository>(
    () => OfficeRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IOfficeRemoteDataSource>(
    () => OfficeRemoteDataSource(),
  );

  sl.registerLazySingleton<IOfficeLocalDataSource>(
    () => OfficeLocalDataSource(sharedPreferences: sl()),
  );

  // Repository places
  sl.registerLazySingleton<IPlaceRepository>(
    () => PlaceRepository(
      remoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IPlaceRemoteDataSource>(
    () => PlaceRemoteDataSource(),
  );

  // Repository booking
  sl.registerLazySingleton<IBookingRepository>(
    () => BookingRepository(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<IBookingRemoteDataSource>(
    () => BookingRemoteDataSource(),
  );

  sl.registerLazySingleton<IBookingLocalDataSource>(
    () => BookingLocalDataSource(sharedPreferences: sl()),
  );

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
