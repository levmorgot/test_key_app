import 'package:key_test_project/core/error/exception.dart';
import 'package:key_test_project/offices/data/models/office_model.dart';

abstract class IOfficeRemoteDataSource {
  Future<List<OfficeModel>> getAllOffices();
}

class OfficeRemoteDataSource implements IOfficeRemoteDataSource {
  @override
  Future<List<OfficeModel>> getAllOffices() async {
    return await _getOfficesFromUrl('smthUrl');
  }

  Future<List<OfficeModel>> _getOfficesFromUrl(String url) async {
    // Здась будет запрос к Бэкенду

    // final response = await client
    //     .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    // if (response.statusCode == 200) {
    //   final offices = json.decode(response.body)['data'];
    //   return (offices as List)
    //       .map((office) => OfficeModel.fromJson(office))
    //       .toList();

    // Это хардкодный варинат без бэка
    if (true) {
      return [
        OfficeModel.fromJson(const {
          'id': 303,
          'name': 'Кузнекцкий мост',
          'address': 'Кузнекцкий мост, 24',
        }),
        OfficeModel.fromJson(const {
          'id': 305,
          'name': 'Чистые пруды',
          'address': 'Чистые пруды, 198',
        }),
      ];
    } else {
      throw ServerException();
    }
  }
}
