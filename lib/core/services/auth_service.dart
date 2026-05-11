import 'dart:math';

import 'package:clockly/core/components/custom_snackbar.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/controllers/auth_helper.dart';
import 'package:clockly/features/auth/model/user_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../routes/app_routes.dart';

class AuthService extends GetxService {
  final _supabase = Supabase.instance.client;

  final isLoggedIn = false.obs;
  final Rxn<UserModel> currentUser = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    _supabase.auth.onAuthStateChange.listen((data) async {
      final event = data.event;
      final session = data.session;

      if (event == AuthChangeEvent.initialSession) {
        if (session != null) {
          await Future.delayed(const Duration(seconds: 2));
          _fetchRoleAndRoute(session.user.id);
        } else {
          _handleNoSession();
        }
      } else if (event == AuthChangeEvent.signedIn) {
        if (session != null) {
          _fetchRoleAndRoute(session.user.id);
        }
      } else if (event == AuthChangeEvent.signedOut) {
        _clearStateAndGoToLogin();
      }
    });
  }

  Future<void> _handleNoSession() async {
    await Future.delayed(const Duration(seconds: 1));
    _clearStateAndGoToLogin();
  }

  Future<void> _fetchRoleAndRoute(String userId) async {
    try {
      AuthHelper.showLoading();
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      currentUser.value = UserModel.fromMap(response);

      final role = currentUser.value!.role;
      const allowedRoles = ['admin', 'manager', 'employee'];

      if (allowedRoles.contains(role)) {
        AuthHelper.hideLoading();
        Get.offAllNamed(AppRoutes.home);
      } else {
        AuthHelper.hideLoading();
        CustomSnackbar.snackbar('Error', 'Invalid role', AppColors.red);
        logout();
      }
    } catch (e) {
      AuthHelper.hideLoading();
      CustomSnackbar.snackbar('System Error', 'Could not fetch user profile.', AppColors.red);
      logout();
    }
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  Future<void> sendPasswordReset (String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  Future<void> verifyOTP (String email, String otp, OtpType type) async {
    await _supabase.auth.verifyOTP(
        type: type,
      token: otp,
      email: email
    );
  }

  Future<void> signIn (String email, String password) async {
    await _supabase.auth.signInWithPassword(
        password: password,
      email: email
    );
  }

  void _clearStateAndGoToLogin() {
    isLoggedIn.value = false;
    currentUser.value = null;
    Get.offAllNamed(AppRoutes.login);
  }
}