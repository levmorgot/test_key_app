import 'package:key_test_project/offices/data/models/office_model.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';

class PlaceModel extends PlaceEntity {
  const PlaceModel({required id, required office, required number})
      : super(id: id, office: office, number: number);

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'],
      office: OfficeModel.fromJson(json['office']),
      number: json['number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'office': office,
      'number': number,
    };
  }
}
