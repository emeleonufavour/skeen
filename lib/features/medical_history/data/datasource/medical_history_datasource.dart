import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

// final supabaseClient = Supabase.instance.client;

// Providers

// Medical History Data Source Provider
final medicalHistoryRemoteDataSourceProvider =
    Provider<MedicalHistoryDatasource>(
  (ref) => MedicalHistoryDataSourceImpl(
    firebaseHelper: FirebaseHelper(),
  ),
);

// Medical history data source implementation
abstract class MedicalHistoryDatasource {
  Future<BaseModel> uploadMedicalHistory(Map<String, dynamic> answers);
}

class MedicalHistoryDataSourceImpl extends MedicalHistoryDatasource {
  final FirebaseHelper firebaseHelper;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MedicalHistoryDataSourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<BaseModel> uploadMedicalHistory(Map<String, dynamic> answers) async {
    final String? userId = _auth.currentUser?.uid;

    if (userId == null) {
      throw const BaseFailures(message: "User not authenticated");
    }

    await firebaseHelper.insertMedicalHistory(
      userId: userId,
      data: answers,
    );

    return BaseModel(
      message: 'Medical History uploaded successfully!',
      isSuccess: true,
    );
  }
}
