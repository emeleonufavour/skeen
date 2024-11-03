import 'package:fpdart/fpdart.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

class MedicalHistoryRepoImpl extends MedicalHistoryRepository
    with RepositoryErrorHandler {
  @override
  Future<Either<Failure, BaseEntity>> uploadMedicalHistory(
    Map<String, dynamic> questions,
  ) async {
    return callAction(
      () => _medicalHistoryDatasource.uploadMedicalHistory(questions),
    );
  }

  final MedicalHistoryDatasource _medicalHistoryDatasource;

  MedicalHistoryRepoImpl({
    required MedicalHistoryDatasource medicalHistoryDatasource,
  }) : _medicalHistoryDatasource = medicalHistoryDatasource;
}
