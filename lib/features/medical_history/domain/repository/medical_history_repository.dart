import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

final medicalHistoryRepositoryProvider = Provider<MedicalHistoryRepository>(
  (ref) => MedicalHistoryRepoImpl(
    medicalHistoryDatasource: ref.read(medicalHistoryRemoteDataSourceProvider),
  ),
);

abstract class MedicalHistoryRepository {
  Future<Either<Failure, BaseEntity>> uploadMedicalHistory(
    Map<String, dynamic> questions,
  );
}
