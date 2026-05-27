import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clockly/core/theme/app_colors.dart';
import 'package:clockly/core/utils/theme_helper.dart';
import 'package:clockly/features/setting/widgets/heading_setting.dart';
import 'package:clockly/core/components/heading_text_page.dart';
import 'package:clockly/features/leader_board/widget/leaderboard_search_bar.dart';
import 'package:clockly/features/task_home/widgets/text_title_add_task.dart';
import 'package:clockly/features/task_home/widgets/pick_date_add_task.dart';
import 'package:clockly/features/task_home/controllers/task_home_controller.dart';
import 'package:clockly/core/utils/dialog_helper.dart';
import 'package:clockly/features/setting/widgets/preferences_section.dart';
import 'package:clockly/features/setting/controller/settings_controller.dart';
import 'package:get/get.dart';

void main() {
  test('Should resolve string preferences correctly to ThemeMode', () {
    expect(ThemeHelper.stringToThemeMode('dark'), ThemeMode.dark);
    expect(ThemeHelper.stringToThemeMode('light'), ThemeMode.light);
    expect(ThemeHelper.stringToThemeMode('system'), ThemeMode.system);
    expect(ThemeHelper.stringToThemeMode(null), ThemeMode.system);
    expect(ThemeHelper.stringToThemeMode('invalid'), ThemeMode.system);
  });

  test(
    'Verify baseline AppColors resolve correctly in default light state',
    () {
      expect(AppColors.primary, const Color(0xFF004AC6));
    },
  );

  testWidgets(
    'HeadingSetting renders correct text colors in Light and Dark Mode',
    (WidgetTester tester) async {
      // 1. Light Mode
      ThemeHelper.isDark = false;
      await tester.pumpWidget(
        const GetMaterialApp(
          home: Scaffold(body: HeadingSetting(text: '')),
        ),
      );
      await tester.pumpAndSettle();

      // Check "Settings" text style color
      final textFinder = find.text("Settings");
      expect(textFinder, findsOneWidget);
      final Text textWidget = tester.widget(textFinder);
      expect(textWidget.style?.color, Colors.black87);

      // 2. Switch to Dark Mode
      ThemeHelper.isDark = true;
      await tester.pumpAndSettle();

      final Text textWidgetDark = tester.widget(textFinder);
      expect(textWidgetDark.style?.color, Colors.white);
    },
  );

  testWidgets(
    'EditProfileHeader renders correct text colors in Light and Dark Mode',
    (WidgetTester tester) async {
      // 1. Light Mode
      ThemeHelper.isDark = false;
      await tester.pumpWidget(
        GetMaterialApp(home: Scaffold(body: EditProfileHeader())),
      );
      await tester.pumpAndSettle();

      // Check "Edit Profile" text style color
      final textFinder = find.text("Edit Profile");
      expect(textFinder, findsOneWidget);
      final Text textWidget = tester.widget(textFinder);
      expect(textWidget.style?.color, Colors.black87);

      // 2. Switch to Dark Mode
      ThemeHelper.isDark = true;
      await tester.pumpAndSettle();

      final Text textWidgetDark = tester.widget(textFinder);
      expect(textWidgetDark.style?.color, Colors.white);
    },
  );

  testWidgets(
    'HeadingTextPage renders correct text colors in Light and Dark Mode',
    (WidgetTester tester) async {
      // 1. Light Mode
      ThemeHelper.isDark = false;
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(body: HeadingTextPage(text: "Analytics")),
        ),
      );
      await tester.pumpAndSettle();

      final textFinder = find.text("Analytics");
      expect(textFinder, findsOneWidget);
      final Text textWidget = tester.widget(textFinder);
      expect(textWidget.style?.color, Colors.black87);

      // 2. Switch to Dark Mode
      ThemeHelper.isDark = true;
      await tester.pumpAndSettle();

      final Text textWidgetDark = tester.widget(textFinder);
      expect(textWidgetDark.style?.color, Colors.white);
    },
  );

  testWidgets(
    'LeaderboardSearchBar renders correct background and text colors',
    (WidgetTester tester) async {
      // 1. Light Mode
      ThemeHelper.isDark = false;
      await tester.pumpWidget(
        GetMaterialApp(home: Scaffold(body: const LeaderboardSearchBar())),
      );
      await tester.pumpAndSettle();

      final containerFinder = find.byType(Container);
      expect(containerFinder, findsOneWidget);
      final Container containerWidget = tester.widget(containerFinder);
      final decoration = containerWidget.decoration as BoxDecoration;
      expect(
        decoration.color,
        const Color(0xFFFFFFFF),
      ); // AppColors.secondary light

      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);
      final TextField textFieldWidget = tester.widget(textFieldFinder);
      expect(textFieldWidget.style?.color, Colors.black87);

      // 2. Switch to Dark Mode
      ThemeHelper.isDark = true;
      await tester.pumpAndSettle();

      final Container containerWidgetDark = tester.widget(containerFinder);
      final decorationDark = containerWidgetDark.decoration as BoxDecoration;
      expect(
        decorationDark.color,
        const Color(0xFF1E1E1E),
      ); // AppColors.secondary dark

      final TextField textFieldWidgetDark = tester.widget(textFieldFinder);
      expect(textFieldWidgetDark.style?.color, Colors.white);
    },
  );

  testWidgets(
    'TextTitleAddTask renders correct text colors in Light and Dark Mode',
    (WidgetTester tester) async {
      // 1. Light Mode
      ThemeHelper.isDark = false;
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(body: TextTitleAddTask(text: "Description")),
        ),
      );
      await tester.pumpAndSettle();

      final textFinder = find.text("Description");
      expect(textFinder, findsOneWidget);
      final Text textWidget = tester.widget(textFinder);
      expect(textWidget.style?.color, Colors.black);

      // 2. Switch to Dark Mode
      ThemeHelper.isDark = true;
      await tester.pumpAndSettle();

      final Text textWidgetDark = tester.widget(textFinder);
      expect(textWidgetDark.style?.color, Colors.white);
    },
  );

  testWidgets(
    'PickDateAddTask text field text style color is dynamic based on theme mode',
    (WidgetTester tester) async {
      // Register MockTaskHomeController
      final mockController = MockTaskHomeController();
      Get.put<TaskHomeController>(mockController);

      // 1. Light Mode
      ThemeHelper.isDark = false;
      await tester.pumpWidget(
        GetMaterialApp(home: Scaffold(body: PickDateAddTask())),
      );
      await tester.pumpAndSettle();

      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);
      final TextField textFieldWidget = tester.widget(textFieldFinder);
      expect(textFieldWidget.style?.color, Colors.black87);

      // 2. Switch to Dark Mode
      ThemeHelper.isDark = true;
      await tester.pumpAndSettle();

      final TextField textFieldWidgetDark = tester.widget(textFieldFinder);
      expect(textFieldWidgetDark.style?.color, Colors.white);

      // Clean up
      Get.delete<TaskHomeController>();
    },
  );

  testWidgets(
    'CustomDialog.confirmDialog renders correct colors in Light and Dark Mode',
    (WidgetTester tester) async {
      // 1. Light Mode
      ThemeHelper.isDark = false;
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    CustomDialog.confirmDialog(
                      title: "Discard draft?",
                      content: "Your changes haven't been saved yet.",
                      cancel: "Keep editing",
                      confirm: "Discard",
                      onConfirm: () {},
                    );
                  },
                  child: const Text("Show Dialog"),
                );
              },
            ),
          ),
        ),
      );

      // Open dialog
      await tester.tap(find.text("Show Dialog"));
      await tester.pumpAndSettle();

      // Verify title text color in Light Mode
      final titleFinder = find.text("Discard draft?");
      expect(titleFinder, findsOneWidget);
      final Text titleWidget = tester.widget(titleFinder);
      expect(titleWidget.style?.color, Colors.black87);

      // Verify container background color in Light Mode
      final containerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).borderRadius != null,
      );
      final Container dialogContainer = tester.widget(containerFinder.first);
      final decoration = dialogContainer.decoration as BoxDecoration;
      expect(decoration.color, const Color(0xFFF7F7FA));

      // Close Dialog
      Get.back();
      await tester.pumpAndSettle();

      // 2. Switch to Dark Mode
      ThemeHelper.isDark = true;
      await tester.pumpWidget(
        GetMaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    CustomDialog.confirmDialog(
                      title: "Discard draft?",
                      content: "Your changes haven't been saved yet.",
                      cancel: "Keep editing",
                      confirm: "Discard",
                      onConfirm: () {},
                    );
                  },
                  child: const Text("Show Dialog"),
                );
              },
            ),
          ),
        ),
      );

      // Open dialog
      await tester.tap(find.text("Show Dialog"));
      await tester.pumpAndSettle();

      // Verify title text color in Dark Mode
      final titleFinderDark = find.text("Discard draft?");
      expect(titleFinderDark, findsOneWidget);
      final Text titleWidgetDark = tester.widget(titleFinderDark);
      expect(titleWidgetDark.style?.color, Colors.white);

      // Verify container background color in Dark Mode
      final Container dialogContainerDark = tester.widget(
        containerFinder.first,
      );
      final decorationDark = dialogContainerDark.decoration as BoxDecoration;
      expect(decorationDark.color, const Color(0xFF1E1E1E));

      // Clean up
      Get.back();
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'PreferencesSection renders correctly and adapts to light and dark theme mode',
    (WidgetTester tester) async {
      // Register MockSettingsController
      final mockController = MockSettingsController();
      Get.put<SettingsController>(mockController);

      // 1. Light Mode
      ThemeHelper.isDark = false;
      await tester.pumpWidget(
        const GetMaterialApp(home: Scaffold(body: PreferencesSection())),
      );
      await tester.pumpAndSettle();

      // Verify background color is AppColors.secondary in Light Mode
      final containerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).borderRadius ==
                BorderRadius.circular(16),
      );
      expect(containerFinder, findsOneWidget);
      final Container containerWidget = tester.widget(containerFinder);
      final decoration = containerWidget.decoration as BoxDecoration;
      expect(
        decoration.color,
        const Color(0xFFFFFFFF),
      ); // AppColors.secondary in light mode

      // 2. Switch to Dark Mode
      ThemeHelper.isDark = true;
      await tester.pumpAndSettle();

      final Container containerWidgetDark = tester.widget(containerFinder);
      final decorationDark = containerWidgetDark.decoration as BoxDecoration;
      expect(
        decorationDark.color,
        const Color(0xFF1E1E1E),
      ); // AppColors.secondary in dark mode

      // Clean up
      Get.delete<SettingsController>();
    },
  );
}

class MockSettingsController extends GetxController
    implements SettingsController {
  @override
  final isNotiEnabled = false.obs;

  @override
  final selectedAppearance = "System".obs;

  @override
  Future<void> handleNotificationTap() async {}

  @override
  Future<void> changeAppearance(String mode) async {
    selectedAppearance.value = mode;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class MockTaskHomeController extends GetxController
    implements TaskHomeController {
  @override
  final dateController = TextEditingController();

  @override
  void updateDueDate(DateTime date) {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
