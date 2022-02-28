import 'package:equatable/equatable.dart';

class PlaceParams extends Equatable {
  final int officeId;

  const PlaceParams({
    required this.officeId,
  });


  @override
  List<Object?> get props => [officeId];
}