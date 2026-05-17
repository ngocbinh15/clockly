import 'package:clockly/core/components/custom_snackbar.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/features/auth/model/user_model.dart';
import 'package:flutter/foundation.dart';
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
    setupAuthListener();
  }

  Future<void> setupAuthListener() async {
    final session = _supabase.auth.currentSession;

    if (session != null) {
      debugPrint("[AuthService] Đã tìm thấy session, đang tải profile...");
      await _fetchProfileAndRoute(session.user.id);
    } else {
      debugPrint("[AuthService] Không có session, chuẩn bị ra màn Login.");
      _handleNoSession();
    }

    _supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      final session = data.session;

      debugPrint("[AuthService] Sự kiện Auth mới: $event");

      if (event == AuthChangeEvent.signedIn && session != null) {
        _fetchProfileAndRoute(session.user.id);
      } else if (event == AuthChangeEvent.signedOut) {
        _clearStateAndGoToLogin();
      }
    });
  }

  Future<void> _handleNoSession() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    _clearStateAndGoToLogin();
  }

  Future<void> _fetchProfileAndRoute(String userId) async {
    try {
      final response = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      currentUser.value = UserModel.fromMap(response);
      isLoggedIn.value = true;

      debugPrint("[AuthService] Tải profile thành công");
      Get.offAllNamed(AppRoutes.home);

    } catch (e, stacktrace) {
      debugPrint('[AuthService] LỖI TẢI PROFILE: $e\n$stacktrace');
      CustomSnackbar.snackbar(
          'Lỗi kết nối',
          'Không thể lấy dữ liệu người dùng. Vui lòng kiểm tra mạng.',
          AppColors.red
      );
      _clearStateAndGoToLogin();
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    await _supabase.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': name,
      },
    );
  }

  Future<void> signIn(String email, String password) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> verifyOTP(String email, String otp, OtpType type) async {
    await _supabase.auth.verifyOTP(
      type: type,
      token: otp,
      email: email,
    );
  }

  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  Future<void> sendPasswordReset(String email) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  Future<void> resetPassword(String password) async {
    await _supabase.auth.updateUser(
      UserAttributes(password: password),
    );
  }

  void _clearStateAndGoToLogin() {
    isLoggedIn.value = false;
    currentUser.value = null;
    Get.offAllNamed(AppRoutes.login);
  }
}