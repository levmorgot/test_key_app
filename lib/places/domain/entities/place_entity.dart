import 'package:equatable/equatable.dart';
import 'package:key_test_project/offices/domain/entities/office_entity.dart';

class PlaceEntity extends Equatable {
  final int id;
  final OfficeEntity office;
  final int number;

  const PlaceEntity({
    required this.id,
    required this.office,
    required this.number,
  });

  @override
  List<Object?> get props => [id, office, number];
}
