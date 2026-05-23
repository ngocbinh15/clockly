import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';import 'package:url_launcher/url_launcher.dart';
import '../../../core/supabase/supabase_helper.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../controllers/settings_controller.dart';

class PageSettings extends StatelessWidget {
  PageSettings({super.key});

  final SettingsController controller = Get.put(SettingsController());

  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
        id: "settings",
        init: controller,
        builder: (controller) {
          Color changeBgrColor;
          Color colorCard;
          Color colorMainText;
          Color colorText;
          if (controller.selectedAppearance == "dark") {
            changeBgrColor = const Color(0xFF1A1A1A);
            colorCard = const Color(0xFF2C2C2C);
            colorMainText = Colors.white;
            colorText = Colors.white70;
          } else {
            changeBgrColor = AppColors.background;
            colorCard = Colors.white;
            colorMainText = Colors.black87;
            colorText = AppColors.grey;
          }

          return Scaffold(
            backgroundColor: changeBgrColor,
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                children: [
                  Text(
                      "Settings",
                      style: AppTextStyles.heading.copyWith(color: colorMainText)
                  ),
                  const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
              child: Text(
                "ACCOUNT",
                style: AppTextStyles.caption.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: colorText,
                ),
              ),
            ),
            Card(
              color: colorCard,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  GetBuilder<SettingsController>(
                    id: "settings",
                    init: controller,
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const PageEditProfile(),)
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(shape: BoxShape.circle,),
                                clipBehavior: Clip.antiAlias,
                                child: Builder(
                                  builder: (context) {
                                    if (controller.avatarUrl.isNotEmpty) {
                                      return Image.network(
                                        controller.avatarUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) => Center(
                                          child: Icon(Icons.broken_image, color: AppColors.grey),
                                        ),
                                      );
                                    } else {
                                      return Center(
                                        child: Icon(Icons.person, color: AppColors.grey),
                                      );
                                    }
                                  },
                                ),
                              ),

                              const SizedBox(width: 16),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.userName,
                                      style: AppTextStyles.title.copyWith(
                                        color: colorMainText,
                                      ),
                                    ),
                                    const SizedBox(height: 1),
                                    Text(
                                      controller.userEmail,
                                      style: AppTextStyles.caption.copyWith(
                                        color: colorText,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.chevron_right,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: AppColors.secondary,
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple.withValues(alpha: 0.1),
                                shape: BoxShape.circle
                            ),
                            child: Icon(Icons.credit_card, color: AppColors.manage, size: 20),
                          ),

                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              "Manage Subscription",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: colorMainText,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  "PRO",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blue,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 4),
                              const Icon(
                                Icons.chevron_right,
                                color: AppColors.grey,
                                size: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                    child: Text(
                      "PREFERENCES",
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: colorText,
                      ),
                    ),
                  ),
                  Card(
                    color: colorCard,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await controller.handleNotificationTap();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Builder(
                                  builder: (context) {
                                    if (controller.isNotiEnabled == true) {
                                      return Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.deepOrange.withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.notifications_active, color: Colors.deepOrange, size: 20),
                                      );
                                    } else {
                                      return Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.grey.withValues(alpha: 0.1),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(Icons.notifications_off, color: AppColors.grey, size: 20),
                                      );
                                    }
                                  },
                                ),

                                const SizedBox(width: 16),

                                Expanded(
                                  child: Text(
                                    "Notifications",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: colorMainText,
                                    ),
                                  ),
                                ),

                                const Icon(Icons.chevron_right, color: AppColors.grey, size: 20),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          indent: 16,
                          endIndent: 16,
                          color: AppColors.secondary,
                        ),
                        GetBuilder<SettingsController>(
                            id: "settings",
                            builder: (controller) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: AppColors.purple.withValues(alpha: 0.1),
                                          shape: BoxShape.circle
                                      ),
                                      child: Icon(Icons.palette_outlined, color: AppColors.pur, size: 20),
                                    ),

                                    const SizedBox(width: 16),

                                    Expanded(
                                      child: Text(
                                        "Appearance",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: colorMainText,
                                        ),
                                      ),
                                    ),

                                    DropdownButton<String>(
                                      dropdownColor: colorCard,
                                      underline: const SizedBox(),
                                      icon: const Icon(Icons.chevron_right, color: AppColors.grey, size: 20),

                                      value: controller.selectedAppearance,

                                      items: controller.appearanceList.map(
                                            (e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e,
                                            style: const TextStyle(
                                              fontSize: 13.5,
                                              color: AppColors.grey,
                                            ),
                                          ),
                                        ),
                                      ).toList(),
                                      onChanged: (value) {
                                        controller.changeAppearance(value);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                        ),

                        const Divider(
                          height: 1,
                          indent: 16,
                          endIndent: 16,
                          color: AppColors.secondary,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: AppColors.mint.withValues(alpha: 0.1),
                                      shape: BoxShape.circle
                                  ),
                                  child: Icon(Icons.extension_outlined, color: AppColors.mint, size: 20),
                                ),
                                const SizedBox(width: 16),

                                Expanded(
                                  child: Text(
                                    "Integrations",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: colorMainText,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.chevron_right, color: AppColors.grey, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                    child: Text(
                      "SUPPORT & ABOUT",
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: colorText,
                      ),
                    ),
                  ),
                  Card(
                    color: colorCard,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            String mailMain = "binhnguyenngoc.it@gmail.com";
                            String url = "mailto:$mailMain?subject=Support request&body=Dear customer service, ";

                            bool check = await canLaunchUrl(Uri.parse(url));
                            if (check == true) {
                              await launchUrl(Uri.parse(url));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Không thể mở ứng dụng Mail, vui lòng kiểm tra lại."),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: AppColors.primary.withValues(alpha: 0.1),
                                      shape: BoxShape.circle
                                  ),
                                  child: const Icon(Icons.help_outline,
                                      color: AppColors.primary,
                                      size: 20
                                  ),
                                ),

                                const SizedBox(width: 16),

                                Expanded(
                                  child: Text(
                                    "Help Center",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: colorMainText,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.open_in_new, color: AppColors.grey, size: 20),
                              ],
                            ),
                          ),
                        ),
                        const Divider(
                          height: 1,
                          indent: 16,
                          endIndent: 16,
                          color: AppColors.secondary,
                        ),

                        GestureDetector(
                          onTap: () {
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey.withValues(alpha: 0.1),
                                      shape: BoxShape.circle
                                  ),
                                  child: const Icon(Icons.lock_outline, color: Colors.blueGrey, size: 20),
                                ),

                                const SizedBox(width: 16),

                                Expanded(
                                  child: Text(
                                    "Privacy & Terms",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: colorMainText,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.chevron_right, color: AppColors.grey, size: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  GestureDetector(
                    onTap: () async {
                      try {
                        await Supabase.instance.client.auth.signOut();
                        Get.offAllNamed('/login');
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Đăng xuất thất bại, vui lòng thử lại."),
                          ),
                        );
                      }
                    },
                    child: Card(
                      color: colorCard,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: AppColors.red.withValues(alpha: 1),
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Log Out",
                              style: TextStyle(
                                color: AppColors.red.withValues(alpha: 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        }
    );
  }
}

class PageEditProfile extends StatefulWidget {
  const PageEditProfile({super.key});

  @override
  State<PageEditProfile> createState() => _PageEditProfileState();
}

class _PageEditProfileState extends State<PageEditProfile> {
  final SettingsController controller = Get.find<SettingsController>();

  XFile? _xFile;
  final TextEditingController txtTen = TextEditingController();

  @override
  void initState() {
    super.initState();
    txtTen.text = controller.userName;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
        id: "settings",
        builder: (controller) {
          Color mauNenPage = controller.selectedAppearance == "dark" ? const Color(0xFF1A1A1A) : AppColors.background;
          Color mauChuChinh = controller.selectedAppearance == "dark" ? Colors.white : Colors.black87;

          return Scaffold(
            backgroundColor: mauNenPage,
            appBar: AppBar(
              title: Text("Chỉnh sửa tài khoản", style: TextStyle(color: mauChuChinh)),
              backgroundColor: mauNenPage,
              iconTheme: IconThemeData(color: mauChuChinh),
              elevation: 0,
            ),
            body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.width * 0.6,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: _xFile == null
                            ? (controller.avatarUrl.isNotEmpty
                            ? Image.network(controller.avatarUrl, fit: BoxFit.cover)
                            : const Icon(Icons.image, size: 80))
                            : Image.file(File(_xFile!.path), fit: BoxFit.cover),
                      ),

                      const SizedBox(height: 16),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () async {
                                var imagePicker = await ImagePicker().pickImage(source: ImageSource.gallery);
                                if(imagePicker != null){
                                  setState(() {
                                    _xFile = imagePicker;
                                  });
                                }
                              },
                              child: const Icon(Icons.camera_alt)
                          ),
                        ),
                      ),

                      TextField(
                        controller: txtTen,
                        style: TextStyle(color: mauChuChinh),
                        decoration: InputDecoration(
                          labelText: "Tên hiển thị",
                          labelStyle: TextStyle(color: mauChuChinh.withOpacity(0.7)),
                        ),
                      ),

                      const SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("close")
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                              onPressed: () async {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Uploading Profile..."),
                                      duration: Duration(seconds: 10),
                                    )
                                );

                                try {
                                  String finalAvatarUrl = controller.avatarUrl;
                                  final user = Supabase.instance.client.auth.currentUser;

                                  if(_xFile != null && user != null){
                                    final fileExt = _xFile!.name.split('.').last;
                                    final fileName = '${user.id}_avatar.$fileExt';

                                    finalAvatarUrl = await updateImage(
                                      image: File(_xFile!.path),
                                      bucket: "images",
                                      path: "avatar/$fileName",
                                      upsert: true,
                                    );
                                  }

                                  if (user != null) {
                                    await Supabase.instance.client.from('profiles').update({
                                      'full_name': txtTen.text,
                                      'avatar_url': finalAvatarUrl,
                                    }).eq('id', user.id);
                                    await controller.loadUserData();
                                  }
                                  ScaffoldMessenger.of(context).clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text("Uploaded Profile Successfully"))
                                  );

                                  Navigator.of(context).pop();

                                } catch (e) {
                                  ScaffoldMessenger.of(context).clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Error: $e"))
                                  );
                                }
                              },
                              child: const Text("Save")
                          ),
                        ],
                      )
                    ],
                  ),
                )),
          );
        }
    );
  }
}