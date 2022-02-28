import 'package:dartz/dartz.dart';
import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/core/usecases/usecase.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';
import 'package:key_test_project/places/domain/repositories/place_repository.dart';
import 'package:key_test_project/places/domain/usecases/params/place_params.dart';

class GetAllPlaces extends UseCase<List<PlaceEntity>, PlaceParams> {
  final IPlaceRepository placeRepository;

  GetAllPlaces(this.placeRepository);

  @override
  Future<Either<Failure, List<PlaceEntity>>> call(
      PlaceParams params) async {
    return await placeRepository.getAllPlaces(params.officeId);
  }
}
