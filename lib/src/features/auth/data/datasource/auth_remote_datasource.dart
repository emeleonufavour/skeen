import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myskin_flutterbytes/src/features/features.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(
    firebaseHelper: FirebaseHelper(),
    googleSignIn: GoogleSignIn(),
  ),
);

abstract interface class AuthRemoteDataSource {
  Future<AuthResultModel> login(String email, String password);

  Future<AuthResultModel> signUp(SignUpParamsModel signUpForm);

  Future<AuthResultModel> signInWithGoogle();

  Future<void> forgotPassword(String email);

  Future<void> logOut();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final FirebaseHelper _firebaseHelper;
  final GoogleSignIn _googleSignIn;

  AuthRemoteDataSourceImpl({
    required FirebaseHelper firebaseHelper,
    required GoogleSignIn googleSignIn,
  })  : _firebaseHelper = firebaseHelper,
        _googleSignIn = googleSignIn;

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

    await _saveUser(user: user, params: signUpForm);

    return const AuthResultModel(
      success: true,
      message: 'Account created successfully!',
    );
  }

  Future<void> _saveUser({
    required User user,
    SignUpParamsModel? params,
    bool isEmailAuth = true,
  }) async {
    _firebaseHelper.userCollectionRef().doc(user.uid).set({
      'user_id': user.uid,
      'email': user.email,
      'fullname': params?.fullName ?? user.displayName,
      'createdAt': _firebaseHelper.timestamp,
      'auth_type': isEmailAuth,
    });
  }

  @override
  Future<AuthResultModel> signInWithGoogle() async {
    final GoogleSignInAccount? user = await _googleSignIn.signIn();

    if (user == null) {
      throw const NoGoogleAccountChosenException();
    }
    final GoogleSignInAuthentication googleAuth = await user.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userDetailsResponse =
        await FirebaseAuth.instance.signInWithCredential(credential);

    await _saveUser(
      user: userDetailsResponse.user!,
      isEmailAuth: false,
    );

    return const AuthResultModel(
      message: 'Google sign in successful!',
      success: true,
    );
  }
}
