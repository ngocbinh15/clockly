import 'package:clockly/features/setting/widgets/payment_processing_dialog.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/app_colors.dart';

class OptionPlanController extends GetxController {
	var IsChoose = 1.obs;

	var isPro = false.obs;

	var paymentStatus = "Connecting to secure server...".obs;
	var isPaymentProcessing = false.obs;
	var paymentSuccess = false.obs;

		@override
	void onInit() {
		super.onInit();
		loadPro();
	}

	Future<void> processRealisticPayment() async {
		isPaymentProcessing.value = true;
		paymentSuccess.value = false;
		paymentStatus.value = "Connecting to Google Play...";

		Get.dialog(
			const PaymentProcessingDialog(),
			barrierDismissible: false,
		);

		await Future.delayed(const Duration(seconds: 2));
		paymentStatus.value = "Processing your payment...";

		await Future.delayed(const Duration(seconds: 2));
		paymentStatus.value = "Verifying transaction...";

		await Future.delayed(const Duration(seconds: 1));

		isPaymentProcessing.value = false;
		paymentSuccess.value = true;
		paymentStatus.value = "Payment Successful!";

		await Future.delayed(const Duration(seconds: 2));
		isPro.value = true;
		savePro();
		Get.back();


		String planName = IsChoose.value == 1 ? "Yearly Pro" : "Monthly Pro";
		Get.snackbar(
			"Welcome to $planName!",
			"All premium features are now unlocked.",
			backgroundColor: AppColors.green,
			colorText: Colors.white,
			snackPosition: SnackPosition.TOP,
				duration: const Duration(seconds: 1)
		);
	}

	void savePro () async {
		SharedPreferences preferences = await SharedPreferences.getInstance();

		await preferences.setBool('subscription', isPro.value);
	}

	void loadPro () async {
		SharedPreferences preferences = await SharedPreferences.getInstance();

		isPro.value = preferences.getBool('subscription') ?? false;
	}

Future<void> processRestorePayment() async {
		isPaymentProcessing.value = true;
		paymentSuccess.value = false;
		paymentStatus.value = "Connecting to Google Play...";

		Get.dialog(
			const PaymentProcessingDialog(),
			barrierDismissible: false,
		);

		await Future.delayed(const Duration(seconds: 2));
		paymentStatus.value = "Searching for previous purchases...";

		await Future.delayed(const Duration(seconds: 2));
		paymentStatus.value = "Verifying transaction...";

		await Future.delayed(const Duration(seconds: 1));

		isPaymentProcessing.value = false;
		paymentSuccess.value = true;
		paymentStatus.value = "Restore Purchase Successful!";

		await Future.delayed(const Duration(seconds: 2));
		isPro.value = false;
		savePro();
		Get.back();

		Get.snackbar(
				"Welcome back!",
				"Your previous purchases have been restored.",
				backgroundColor: AppColors.green,
				colorText: Colors.white,
				snackPosition: SnackPosition.TOP,
				margin: const EdgeInsets.all(16),
				borderRadius: 16,
				icon: const Icon(Icons.check_circle, color: Colors.white),
				duration: const Duration(seconds: 1)
		);
	}
}