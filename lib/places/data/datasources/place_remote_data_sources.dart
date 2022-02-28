import 'package:key_test_project/core/error/exception.dart';
import 'package:key_test_project/offices/data/models/office_model.dart';
import 'package:key_test_project/places/data/models/place_model.dart';


abstract class IPlaceRemoteDataSource {
  Future<List<PlaceModel>> getAllPlaces(int officeId);
}

class PlaceRemoteDataSource implements IPlaceRemoteDataSource {
  @override
  Future<List<PlaceModel>> getAllPlaces(int officeId) async {
    List<PlaceModel> allPlaces = await _getPlacesFromUrl('smthUrl');
    return allPlaces.where((place) => place.office.id == officeId).toList();
  }

  Future<List<PlaceModel>> _getPlacesFromUrl(String url) async {
    // Здась будет запрос к Бэкенду

    // final response = await client
    //     .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    // if (response.statusCode == 200) {
    //   final places = json.decode(response.body)['data'];
    //   return (places as List)
    //       .map((place) => PlaceModel.fromJson(place))
    //       .toList();
    // }

    // Это хардкодный варинат без бэка

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
    if (true) {
      return const [
        PlaceModel(
          id: 12423,
          office: office303,
          number: 1,
        ),
        PlaceModel(
          id: 342534,
          office: office303,
          number: 2,
        ),
        PlaceModel(
          id: 7896,
          office: office303,
          number: 3,
        ),
        PlaceModel(
          id: 6747,
          office: office303,
          number: 4,
        ),
        PlaceModel(
          id: 73457,
          office: office303,
          number: 5,
        ),
        PlaceModel(
          id: 67789,
          office: office305,
          number: 1,
        ),
        PlaceModel(
          id: 78954,
          office: office305,
          number: 2,
        ),
        PlaceModel(
          id: 78547,
          office: office305,
          number: 3,
        ),
      ];
    } else {
      throw ServerException();
    }
  }
}
