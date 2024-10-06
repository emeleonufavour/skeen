import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/cores.dart';
import 'package:skeen/features/features.dart';

final homeDatasourceProvider = Provider<HomeDatasource>(
  (ref) => HomeDatasourceImpl(
    firebaseHelper: FirebaseHelper(),
  ),
);

abstract class HomeDatasource {
  Future<List<TipsAndTricksModel>> getTipsAndTricks();
  Future<UserModel> getUser();
}

class HomeDatasourceImpl extends HomeDatasource {
  final FirebaseHelper firebaseHelper;

  HomeDatasourceImpl({
    required this.firebaseHelper,
  });

  @override
  Future<UserModel> getUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    return UserModel(
      email: currentUser?.email,
      fullName: currentUser?.displayName,
      userId: currentUser?.uid,
    );
  }

  @override
  Future<List<TipsAndTricksModel>> getTipsAndTricks() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await firebaseHelper.tipsAndTricksRef().get();

    final List<TipsAndTricksModel> tipsAndTricks = querySnapshot.docs.map(
      (doc) {
        return TipsAndTricksModel.fromJson(doc.data());
      },
    ).toList();

    return tipsAndTricks;
  }
}
