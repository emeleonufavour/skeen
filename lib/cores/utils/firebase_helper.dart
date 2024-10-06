import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String userCollection = "users";

class FirebaseHelper {
  Timestamp get timestamp => Timestamp.now();

  /// -------- AUTHENTICATION --------- ///
  FirebaseAuth get auth => FirebaseAuth.instance;

  String? get currentUserId {
    final String? userId = auth.currentUser?.uid;
    return userId;
  }

  /// ------ FIRE STORE ------ ///
  CollectionReference<Map<String, dynamic>> userCollectionRef() {
    return FirebaseFirestore.instance.collection(userCollection);
  }

  CollectionReference<Map<String, dynamic>> medicalHistoryRef({
    required String userId,
  }) {
    return userCollectionRef().doc(userId).collection('medical_history');
  }
}
