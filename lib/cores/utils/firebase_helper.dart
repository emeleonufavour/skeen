import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DateTime get timestamp => DateTime.now();

  String? get currentUserId => _auth.currentUser?.uid;

  Future<void> saveUser({
    required User user,
    String? fullName,
    String authType = 'emailPassword',
  }) async {
    await _firestore.collection('users').doc(user.uid).set({
      'user_id': user.uid,
      'email': user.email,
      'full_name': fullName ?? user.displayName,
      'created_at': FieldValue.serverTimestamp(),
      'auth_type': authType,
    }, SetOptions(merge: true));
  }

  Future<List<Map<String, dynamic>>> getTipsAndTricks() async {
    final QuerySnapshot response = await _firestore
        .collection('tips_and_tricks')
        .orderBy('created_at', descending: true)
        .get();

    return response.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return {
        ...data,
        'id': doc.id,
      };
    }).toList();
  }

  Future<void> insertMedicalHistory({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection('medical_history').add({
      ...data,
      'user_id': userId,
      'created_at': FieldValue.serverTimestamp(),
    });
  }
}
