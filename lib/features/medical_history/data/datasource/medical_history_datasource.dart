import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

// final supabaseClient = Supabase.instance.client;

// Providers

final medicalHistoryRemoteDataSourceProvider =
    Provider<MedicalHistoryDatasource>(
  (ref) => MedicalHistoryDataSourceImpl(
    supabaseHelper: SupabaseHelper(),
  ),
);

// Medical history data source implementation
abstract class MedicalHistoryDatasource {
  Future<BaseModel> uploadMedicalHistory(Map<String, dynamic> answers);
}

class MedicalHistoryDataSourceImpl extends MedicalHistoryDatasource {
  final SupabaseHelper supabaseHelper;

  MedicalHistoryDataSourceImpl({
    required this.supabaseHelper,
  });

  @override
  Future<BaseModel> uploadMedicalHistory(Map<String, dynamic> answers) async {
    final String? userId = supabaseHelper.currentUserId;

    if (userId == null) {
      throw const BaseFailures(message: "User not authenticated");
    }

    await supabaseHelper.insertMedicalHistory(
      userId: userId,
      data: answers,
    );

    return BaseModel(
      message: 'Medical History uploaded successfully!',
      isSuccess: true,
    );
  }
}
