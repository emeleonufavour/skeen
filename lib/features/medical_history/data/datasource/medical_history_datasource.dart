import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

final medicalHistoryRemoteDataSourceProvider =
    Provider<MedicalHistoryDatasource>(
  (ref) => MedicalHistoryDataSourceImpl(
    firebaseHelper: FirebaseHelper(),
  ),
);

abstract class MedicalHistoryDatasource {
  Future<BaseModel> uploadMedicalHistory(Map<String, dynamic> answers);
}

class MedicalHistoryDataSourceImpl extends MedicalHistoryDatasource {
  final FirebaseHelper firebaseHelper;

  MedicalHistoryDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<BaseModel> uploadMedicalHistory(Map<String, dynamic> answers) async {
    final String? userId = firebaseHelper.currentUserId;

    await firebaseHelper.medicalHistoryRef(userId: userId!).doc().set(answers);

    return BaseModel(
      message: 'Medical History uploaded successfully!',
      isSuccess: true,
    );
  }
}
