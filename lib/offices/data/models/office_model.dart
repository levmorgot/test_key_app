import 'package:key_test_project/offices/domain/entities/office_entity.dart';

class OfficeModel extends OfficeEntity {
  const OfficeModel({required id, required name, required address})
      : super(
          id: id,
          name: name,
          address: address,
        );

  factory OfficeModel.fromJson(Map<String, dynamic> json) {
    return OfficeModel(
      id: json['id'] ?? -1,
      name: json['name'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
    };
  }
}
