import 'package:firebase_auth/firebase_auth.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(firebaseHelper: FirebaseHelper()),
);

abstract interface class AuthRemoteDataSource {
  Future<AuthResultModel> login(String email, String password);

  Future<AuthResultModel> signUp(SignUpParamsModel signUpForm);

  Future<void> forgotPassword(String email);

  Future<void> logOut();

  Future<bool> isLoggedIn();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseHelper _firebaseHelper;

  AuthRemoteDataSourceImpl({
    required FirebaseHelper firebaseHelper,
  }) : _firebaseHelper = firebaseHelper;

  @override
  Future<void> forgotPassword(String email) async {
    return await _firebaseHelper.auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> logOut() async {
    return await _firebaseHelper.auth.signOut();
  }

  @override
  Future<AuthResultModel> login(String email, String password) async {
    final UserCredential userCredential = await _firebaseHelper.auth
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user == null) {
      throw const BaseFailures(
        message: "Unable to login user with this credential",
      );
    }
    return const AuthResultModel(
      success: true,
      message: 'Login successful!',
    );
  }

  @override
  Future<AuthResultModel> signUp(SignUpParamsModel signUpForm) async {
    final UserCredential userCredential =
        await _firebaseHelper.auth.createUserWithEmailAndPassword(
      email: signUpForm.email,
      password: signUpForm.password,
    );

    if (userCredential.user == null) {
      throw const BaseFailures(
        message: "Unable to create account with this credential",
      );
    }

    final User user = userCredential.user!;

    await _saveUser(user, signUpForm);

    return const AuthResultModel(
      success: true,
      message: 'Account created successfully!',
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    final res = _firebaseHelper.currentUserId != null ||
        _firebaseHelper.currentUserId == '';
    return res;
  }

  Future<void> _saveUser(User user, SignUpParamsModel params) async {
    _firebaseHelper.userCollectionRef().doc(user.uid).set({
      'user_id': user.uid,
      'email': user.email,
      'fullname': params.fullName,
      'createdAt': _firebaseHelper.timestamp,
    });
  }
}
