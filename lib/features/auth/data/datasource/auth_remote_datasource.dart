import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skeen/cores/errors/base_failures.dart';
import 'package:skeen/cores/utils/firebase_helper.dart';
import 'package:skeen/features/auth/data/model/auth_result_model.dart';
import 'package:skeen/features/auth/data/model/sign_up_params_model.dart';

// W/Firestore( 5009): (25.1.1) [WriteStream]: (943d0db) Stream closed with
// status: Status{code=PERMISSION_DENIED, description=Cloud Firestore API has not
//  been used in project skeen-440308 before or it is disabled. Enable it by
//  visiting
//  https://console.developers.google.com/apis/api/firestore.googleapis.com/overview?project=skeen-440308 then retry.
// If you enabled this API recently, wait a few minutes for the action to propagate
// to our systems and retry., cause=null}.

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(
    firebaseHelper: FirebaseHelper(),
  ),
);

abstract interface class AuthRemoteDataSource {
  Future<AuthResultModel> login(String email, String password);
  Future<AuthResultModel> signUp(SignUpParamsModel signUpForm);
  Future<AuthResultModel> signInWithGoogle();
  Future<void> forgotPassword(String email);
  Future<void> logOut();
  Future<bool> isLoggedIn();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseHelper _firebaseHelper;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthRemoteDataSourceImpl({
    required FirebaseHelper firebaseHelper,
  }) : _firebaseHelper = firebaseHelper;

  @override
  Future<void> forgotPassword(String email) async {
    await _auth.sendPasswordResetEmail(
      email: email,
    );
  }

  @override
  Future<void> logOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Future<AuthResultModel> login(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw const BaseFailures(
          message: "Unable to login user with this credential",
        );
      }

      return const AuthResultModel(
        success: true,
        message: 'Login successful!',
      );
    } on FirebaseAuthException catch (e) {
      throw BaseFailures(
        message: e.message ?? "An error occurred during login",
      );
    }
  }

  @override
  Future<AuthResultModel> signUp(SignUpParamsModel signUpForm) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: signUpForm.email,
        password: signUpForm.password,
      );

      if (credential.user == null) {
        throw const BaseFailures(
          message: "Unable to create account with this credential",
        );
      }

      // Update display name
      await credential.user!.updateDisplayName(signUpForm.fullName);

      // Save additional user data
      await _firebaseHelper.saveUser(
        user: credential.user!,
        fullName: signUpForm.fullName,
      );

      return const AuthResultModel(
        success: true,
        message: 'Account created successfully!',
      );
    } on FirebaseAuthException catch (e) {
      throw BaseFailures(
        message: e.message ?? "An error occurred during sign up",
      );
    }
  }

  @override
  Future<AuthResultModel> signInWithGoogle() async {
    try {
      // Trigger the Google Sign In process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        throw const BaseFailures(
          message: "No Google account chosen",
        );
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        await _firebaseHelper.saveUser(
          user: userCredential.user!,
          authType: 'google',
        );
      }

      return const AuthResultModel(
        message: 'Google sign in successful!',
        success: true,
      );
    } catch (e) {
      throw BaseFailures(
        message: e.toString(),
      );
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    return _firebaseHelper.currentUserId != null;
  }
}
