import 'package:dartz/dartz.dart';
import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/offices/domain/entities/office_entity.dart';

abstract class IOfficeRepository {
  Future<Either<Failure, List<OfficeEntity>>> getAllOffices();
}
