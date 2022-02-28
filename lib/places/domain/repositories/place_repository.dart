import 'package:dartz/dartz.dart';
import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';

abstract class IPlaceRepository {
  Future<Either<Failure, List<PlaceEntity>>> getAllPlaces(int officeId);
}
