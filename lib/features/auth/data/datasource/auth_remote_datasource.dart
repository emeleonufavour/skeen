import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeen/cores/errors/base_failures.dart';
import 'package:skeen/cores/utils/exception/firebase_exception.dart';
import 'package:skeen/cores/utils/supabase_helper.dart';
import 'package:skeen/features/auth/data/model/auth_result_model.dart';
import 'package:skeen/features/auth/data/model/sign_up_params_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// final supabaseClient = Supabase.instance.client;

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>(
  (ref) => AuthRemoteDataSourceImpl(
    supabaseHelper: SupabaseHelper(),
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
  final SupabaseHelper _supabaseHelper;

  AuthRemoteDataSourceImpl({
    required SupabaseHelper supabaseHelper,
  }) : _supabaseHelper = supabaseHelper;

  @override
  Future<void> forgotPassword(String email) async {
    await _supabaseHelper.client.auth.resetPasswordForEmail(
      email,
      redirectTo: 'your-app-scheme://reset-callback',
    );
  }

  @override
  Future<void> logOut() async {
    await _supabaseHelper.client.auth.signOut();
  }

  @override
  Future<AuthResultModel> login(String email, String password) async {
    final response = await _supabaseHelper.client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
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
    final response = await _supabaseHelper.client.auth.signUp(
      email: signUpForm.email,
      password: signUpForm.password,
      data: {'full_name': signUpForm.fullName},
    );

    if (response.user == null) {
      throw const BaseFailures(
        message: "Unable to create account with this credential",
      );
    }

    await _supabaseHelper.saveUser(
      user: response.user!,
      fullName: signUpForm.fullName,
    );

    return const AuthResultModel(
      success: true,
      message: 'Account created successfully!',
    );
  }

  @override
  Future<AuthResultModel> signInWithGoogle() async {
    final response = await _supabaseHelper.client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: 'your-app-scheme://google-callback',
    );

    if (!response) {
      throw const NoGoogleAccountChosenException();
    }

    // The user info will be available after the OAuth callback
    final user = _supabaseHelper.client.auth.currentUser;
    if (user != null) {
      await _supabaseHelper.saveUser(
        user: user,
        authType: 'google',
      );
    }

    return const AuthResultModel(
      message: 'Google sign in successful!',
      success: true,
    );
  }

  @override
  Future<bool> isLoggedIn() async {
    return _supabaseHelper.currentUserId != null;
  }
}
