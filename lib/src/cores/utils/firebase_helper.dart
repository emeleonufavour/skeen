import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
