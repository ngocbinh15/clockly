import 'package:clockly/core/components/app_alerts.dart';
import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/features/auth/model/user_model.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TeamController extends GetxController{
  RxList<UserModel> friendList = <UserModel>[].obs;
  final _supabase = Supabase.instance.client;
  final authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    fetchFriendList();
  }

  Future<void> fetchFriendList() async {
    try {
      UserModel currUser = authService.currentUser.value!;

      final response = await _supabase
          .from('friendships')
          .select('''
            id,
            status,
            requester:profiles!requester_id(*),
            receiver:profiles!receiver_id(*)
          ''')
          .or('requester_id.eq.${currUser.id},receiver_id.eq.${currUser.id}')
          .eq('status', 'accepted');

      List<UserModel> friends = [];

      for (var row in response) {
        Map<String, dynamic> friendData;

        if (row['requester']['id'] == currUser.id) {
          friendData = row['receiver'];
        }
        else {
          friendData = row['requester'];
        }

        friends.add(UserModel.fromMap(friendData));
      }

      friendList.assignAll(friends);

    } catch (e) {
      AppAlerts.error(message: "$e");
    }
  }
}