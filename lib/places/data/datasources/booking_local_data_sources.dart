import 'dart:convert';

import 'package:key_test_project/core/error/exception.dart';
import 'package:key_test_project/places/data/models/booking_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// IBookingLocalDataSource нужен только для теста
abstract class IBookingLocalDataSource {
  Future<List<BookingModel>> getBookingsForOfficeFromCache(int officeId);

  Future<List<BookingModel>> getAllBookingsFromCache();

  Future<void> bookingToCache(List<BookingModel> bookings, int officeId);
}

const cacheBookingsList = 'CACHE_BOOKING_LIST';
const cacheBookingsLastEdit = 'CACHE_BOOKING_LAST_EDIT';

// BookingLocalDataSource нужен только для теста
class BookingLocalDataSource implements IBookingLocalDataSource {
  final SharedPreferences sharedPreferences;

  BookingLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> bookingToCache(List<BookingModel> bookings, int officeId) {
    final List<String> jsonBookingList =
        bookings.map((booking) => json.encode(booking.toJson())).toList();
    sharedPreferences.setStringList(
        cacheBookingsList + '-$officeId', jsonBookingList);
    return Future.value();
  }

  @override
  Future<List<BookingModel>> getBookingsForOfficeFromCache(int officeId) {
    final jsonBookingList =
        sharedPreferences.getStringList(cacheBookingsList + '-$officeId');
    if (jsonBookingList != null && jsonBookingList.isNotEmpty) {
      try {
        return Future.value(jsonBookingList
            .map((booking) => BookingModel.fromJson(json.decode(booking)))
            .toList());
      } catch (e) {
        throw CacheException();
      }
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<List<BookingModel>> getAllBookingsFromCache() async {
    try {
    List<BookingModel> bookingsList = await getBookingsForOfficeFromCache(303);
    List<BookingModel> bookingsList305 = await getBookingsForOfficeFromCache(305);
    bookingsList.addAll(bookingsList305);
    return bookingsList;
    } catch (e) {
      throw CacheException();
    }
  }
}
