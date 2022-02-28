import 'dart:convert';

import 'package:key_test_project/core/error/exception.dart';
import 'package:key_test_project/offices/data/models/office_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IOfficeLocalDataSource {
  Future<List<OfficeModel>> getLastOfficesFromCache();

  Future<String> getLastEdit();

  Future<void> officeToCache(List<OfficeModel> offices);

  Future<void> lastEditToCache(String lastEdit);
}

const cacheOfficesList = 'CACHE_OFFICES_LIST';
const cacheOfficesLastEdit = 'CACHE_OFFICES_LAST_EDIT';

class OfficeLocalDataSource implements IOfficeLocalDataSource {
  final SharedPreferences sharedPreferences;

  OfficeLocalDataSource({required this.sharedPreferences});

  @override
  Future<void> officeToCache(List<OfficeModel> offices) {
    final List<String> jsonOfficeList =
        offices.map((office) => json.encode(office.toJson())).toList();
    sharedPreferences.setStringList(cacheOfficesList, jsonOfficeList);
    return Future.value();
  }

  @override
  Future<List<OfficeModel>> getLastOfficesFromCache() {
    final jsonOfficeList = sharedPreferences.getStringList(cacheOfficesList);
    if (jsonOfficeList != null && jsonOfficeList.isNotEmpty) {
      try {
        return Future.value(jsonOfficeList
            .map((office) => OfficeModel.fromJson(json.decode(office)))
            .toList());
      } catch (e) {
        throw CacheException();
      }
    } else if (jsonOfficeList != null && jsonOfficeList.isEmpty) {
      return Future.value([]);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<String> getLastEdit() {
    final jsonPlaceLastEdit = sharedPreferences.getString(cacheOfficesLastEdit);
    if (jsonPlaceLastEdit != null && jsonPlaceLastEdit.isNotEmpty) {
      try {
        return Future.value(jsonPlaceLastEdit);
      } catch (e) {
        throw CacheException();
      }
    } else {
      return Future.value('');
    }
  }

  @override
  Future<void> lastEditToCache(String lastEdit) {
    sharedPreferences.setString(cacheOfficesLastEdit, lastEdit);
    return Future.value();
  }
}
