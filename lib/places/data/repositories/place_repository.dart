import 'package:dartz/dartz.dart';
import 'package:key_test_project/core/error/exception.dart';
import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/places/data/datasources/place_remote_data_sources.dart';
import 'package:key_test_project/places/domain/entities/place_entity.dart';
import 'package:key_test_project/places/domain/repositories/place_repository.dart';

class PlaceRepository implements IPlaceRepository {
  final IPlaceRemoteDataSource remoteDataSource;

  PlaceRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PlaceEntity>>> getAllPlaces(int officeId) async {
    try {
      final remotePlaces = await remoteDataSource.getAllPlaces(officeId);
      return Right(remotePlaces);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
