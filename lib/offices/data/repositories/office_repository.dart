import 'package:dartz/dartz.dart';
import 'package:key_test_project/core/error/exception.dart';
import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/offices/data/datasources/office_local_data_sources.dart';
import 'package:key_test_project/offices/data/datasources/office_remote_data_sources.dart';
import 'package:key_test_project/offices/data/models/office_model.dart';
import 'package:key_test_project/offices/domain/entities/office_entity.dart';
import 'package:key_test_project/offices/domain/repositories/office_repository.dart';

class OfficeRepository implements IOfficeRepository {
  final IOfficeRemoteDataSource remoteDataSource;
  final IOfficeLocalDataSource localDataSource;

  OfficeRepository(
      {required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, List<OfficeEntity>>> getAllOffices() async {
    final allOffices = await _getOffices(() {
      return remoteDataSource.getAllOffices();
    });
    return allOffices.fold(
        (failure) => Left(failure),
        (offices) => Right(offices));
  }

  Future<Either<Failure, String>> _getLastEdit() async {
    try {
      final lastEdit = await localDataSource.getLastEdit();
      return Right(lastEdit);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, List<OfficeModel>>> _getOffices(
      Future<List<OfficeModel>> Function() getOffices) async {
    final lastEdit = await _getLastEdit();
    return lastEdit.fold((failure) => Left(failure), (date) async {
      if (date != DateTime.now().toString().substring(0, 10)) {
        try {
          final remoteOffices = await getOffices();
          localDataSource
              .lastEditToCache(DateTime.now().toString().substring(0, 10));
          localDataSource.officeToCache(remoteOffices);
          return Right(remoteOffices);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        try {
          final localOffices = await localDataSource.getLastOfficesFromCache();
          return Right(localOffices);
        } on CacheException {
          return Left(CacheFailure());
        }
      }
    });
  }
}
