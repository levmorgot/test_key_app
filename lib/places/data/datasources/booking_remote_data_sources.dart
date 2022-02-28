import 'package:key_test_project/core/error/exception.dart';
import 'package:key_test_project/offices/data/models/office_model.dart';
import 'package:key_test_project/places/data/models/booking_model.dart';
import 'package:key_test_project/places/data/models/place_model.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';

abstract class IBookingRemoteDataSource {
  Future<List<BookingModel>> getAllBookings();

  Future<BookingModel> addBooking(PlaceEntity place);
}

class BookingRemoteDataSource implements IBookingRemoteDataSource {

  Future<List<BookingModel>> _getBookingsFromUrl(String url) async {
    // Здась будет запрос к Бэкенду

    // final response = await client
    //     .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    // if (response.statusCode == 200) {
    //   final Bookings = json.decode(response.body)['data'];
    //   return (Bookings as List)
    //       .map((Booking) => BookingModel.fromJson(Booking))
    //       .toList();
    // }

    // Это хардкодный варинат без бэка
    if (true) {
      const office303 = OfficeModel(
        id: 303,
        name: 'Кузнекцкий мост',
        address: 'Кузнекцкий мост, 24',
      );
      const office305 = OfficeModel(
        id: 305,
        name: 'Чистые пруды',
        address: 'Чистые пруды, 198',
      );
      return [
        BookingModel(
          id: 12423,
          place: const PlaceModel(
            id: 12423,
            office: office303,
            number: 1,
            ),
          isMyBooking: false,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        ),
        BookingModel(
          id: 7896,
          place: const PlaceModel(
            id: 7896,
            office: office303,
            number: 3,
          ),
          isMyBooking: false,
          timestamp: (DateTime.now().subtract(const Duration(days: 1))).millisecondsSinceEpoch,
        ),
        BookingModel(
          id: 78547,
          place:  const PlaceModel(
            id: 78547,
            office: office305,
            number: 3,
          ),
          isMyBooking: false,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        ),
      ];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<BookingModel> addBooking(PlaceEntity place) async {
    // Здась будет запрос к Бэкенду

    // Это хардкодный варинат без бэка

    return BookingModel(
      id: place.id,
      place: place,
      isMyBooking: true,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );
  }

  @override
  Future<List<BookingModel>> getAllBookings() async {
    return await _getBookingsFromUrl('smthUrl');
  }
}
