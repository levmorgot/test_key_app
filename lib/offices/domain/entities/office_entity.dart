import 'package:equatable/equatable.dart';

class OfficeEntity extends Equatable {
  final int id;
  final String name;
  final String address;

  const OfficeEntity({
    required this.id,
    required this.name,
    required this.address,
  });

  @override
  List<Object?> get props => [id, name, address];
}