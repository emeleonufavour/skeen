import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  SupabaseClient get client => Supabase.instance.client;

  DateTime get timestamp => DateTime.now();

  String? get currentUserId => client.auth.currentUser?.id;

  Future<void> saveUser({
    required User user,
    String? fullName,
    String authType = 'emailPassword',
  }) async {
    await client.from('users').upsert({
      'user_id': user.id,
      'email': user.email,
      'full_name': fullName ?? user.userMetadata?['full_name'],
      'created_at': timestamp.toIso8601String(),
      'auth_type': authType,
    });
  }

  Future<List<Map<String, dynamic>>> getTipsAndTricks() async {
    final response = await client
        .from('tips_and_tricks')
        .select()
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(response);
  }

  Future<void> insertMedicalHistory({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    await client.from('medical_history').insert({
      ...data,
      'user_id': userId,
      'created_at': DateTime.now().toIso8601String(),
    });
  }
}
