import 'package:dartz/dartz.dart';
import 'package:key_test_project/core/error/failure.dart';
import 'package:key_test_project/core/usecases/usecase.dart';
import 'package:key_test_project/offices/domain/entities/office_entity.dart';
import 'package:key_test_project/offices/domain/repositories/office_repository.dart';

class GetAllOffices extends UseCase<List<OfficeEntity>, void> {
  final IOfficeRepository officeRepository;

  GetAllOffices(this.officeRepository);

  @override
  Future<Either<Failure, List<OfficeEntity>>> call(
      void params) async {
    return await officeRepository.getAllOffices();
  }
}
