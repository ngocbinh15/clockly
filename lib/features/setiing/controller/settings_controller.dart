import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/components/custom_snackbar.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../routes/app_routes.dart';
import '../../auth/controllers/auth_helper.dart';

class SettingsController extends GetxController {
  final authService = Get.find<AuthService>();
  final supabase = Supabase.instance.client;

  var userName = "".obs;
  var userEmail = "".obs;
  var avatarUrl = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = supabase.auth.currentUser;
    if (user != null) {
      try {
        final data = await supabase
            .from('profiles')
            .select()
            .eq('id', user.id)
            .single();

        userName.value = data['full_name'] ?? "Người dùng";
        userEmail.value = data['email'] ?? user.email ?? "";
        avatarUrl.value = data['avatar_url'] ?? "";
      } catch (e) {
        print("Lỗi tải profile: $e");
      }
    }
  }

  Future<void> updateAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    try {
      AuthHelper.showLoading();

      final File file = File(image.path);
      final user = supabase.auth.currentUser;
      if (user == null) throw 'Không tìm thấy người dùng';
      final fileExtension = image.path.split('.').last;
      final fileName = '${user.id}_${DateTime.now().millisecondsSinceEpoch}.$fileExtension';

      await supabase.storage.from('avatars').upload(fileName, file);

      final publicUrl = supabase.storage.from('avatars').getPublicUrl(fileName);

      await supabase
          .from('profiles')
          .update({'avatar_url': publicUrl})
          .eq('id', user.id);

      avatarUrl.value = publicUrl;

      AuthHelper.hideLoading();
      CustomSnackbar.snackbar("Thành công", "Đã cập nhật ảnh đại diện", AppColors.green);

    } catch (e) {
      AuthHelper.hideLoading();
      CustomSnackbar.snackbar("Lỗi cập nhật ảnh", e.toString(), AppColors.red);
    }
  }

  Future<void> logOut() async {
    try {
      AuthHelper.showLoading();
      await authService.logout();
      AuthHelper.hideLoading();
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      AuthHelper.hideLoading();
      CustomSnackbar.snackbar("Lỗi", "Không thể đăng xuất", AppColors.red);
    }
  }
}