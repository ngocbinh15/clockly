import 'package:clockly/core/components/app_alerts.dart';
import 'package:clockly/core/services/auth_service.dart';
import 'package:clockly/features/auth/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../auth/controllers/auth_helper.dart';

class TeamController extends GetxController{
  RxList<UserModel> friendList = <UserModel>[].obs;
  RxList<UserModel> leaderBoard = <UserModel>[].obs;
  RxList<UserModel> filteredLeaderBoard = <UserModel>[].obs;

  RxList<UserModel> searchResults = <UserModel>[].obs;
  RxBool isSearching = false.obs;

  final _supabase = Supabase.instance.client;
  final authService = Get.find<AuthService>();
  RxList<Map<String, dynamic>> pendingRequests = <Map<String, dynamic>>[].obs;

  RealtimeChannel? _realtimeChannel;

  @override
  void onInit() {
    super.onInit();
    fetchFriendList();
    fetchPendingRequests();

    setupRealtimeLeaderBoard();
  }

  void setupRealtimeLeaderBoard () {
    _realtimeChannel = _supabase
        .channel('public:profiles')
        .onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'profiles',
        callback: (payload) {
          fetchFriendList();
        },
    ).subscribe();
  }

  Future<void> fetchFriendList() async {
    try {
      final String userId = authService.currentUser.value!.id;

      final myProfileRes = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      UserModel freshCurrUser = UserModel.fromMap(myProfileRes);

      authService.currentUser.value = freshCurrUser;

      final response = await _supabase
          .from('friendships')
          .select('''
            id,
            status,
            requester:profiles!requester_id(*),
            receiver:profiles!receiver_id(*)
          ''')
          .or('requester_id.eq.$userId,receiver_id.eq.$userId')
          .eq('status', 'accepted');

      List<UserModel> friends = [];

      for (var row in response) {
        Map<String, dynamic> friendData;

        if (row['requester']['id'] == userId) {
          friendData = row['receiver'];
        } else {
          friendData = row['requester'];
        }

        friends.add(UserModel.fromMap(friendData));
      }

      List<UserModel> allCompetitors = List.from(friends);

      allCompetitors.add(freshCurrUser);

      allCompetitors.sort((a, b) => b.totalPoints.compareTo(a.totalPoints));

      filteredLeaderBoard.assignAll(allCompetitors);

      friendList.assignAll(friends);
      leaderBoard.assignAll(allCompetitors);

    } catch (e) {
      AppAlerts.error(message: "$e");
    }
  }

  Future<void> searchGlobalUsers(String query) async {
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }
    try {
      isSearching.value = true;
      final String userId = authService.currentUser.value!.id;

      final response = await _supabase
          .from('profiles')
          .select()
          .neq('id', userId)
          .or('full_name.ilike.%${query.trim()}%,email.ilike.%${query.trim()}%')
          .limit(10);

      searchResults.assignAll(response.map((e) => UserModel.fromMap(e)).toList());
    } catch (e) {
      debugPrint("Search error: $e");
    } finally {
      isSearching.value = false;
    }
  }

  Future<void> sendFriendRequest(String receiverId) async {
    try {
      AuthHelper.showLoading();
      final String userId = authService.currentUser.value!.id;

      final check = await _supabase
          .from('friendships')
          .select()
          .or('and(requester_id.eq.$userId,receiver_id.eq.$receiverId),and(requester_id.eq.$receiverId,receiver_id.eq.$userId)');

      if (check.isNotEmpty) {
        AuthHelper.hideLoading();
        AppAlerts.error(message: "You are already friends or have a pending request!");
        return;
      }

      await _supabase.from('friendships').insert({
        'requester_id': userId,
        'receiver_id': receiverId,
        'status': 'pending'
      });

      AuthHelper.hideLoading();
      AppAlerts.success(message: "Friend request sent!");

    } catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: "Error sending request: $e");
    }
  }
  void searchLocalFriends(String query) {
    if (query.trim().isEmpty) {
      filteredLeaderBoard.assignAll(leaderBoard);
    } else {
      filteredLeaderBoard.assignAll(
          leaderBoard.where((user) =>
          user.fullName.toLowerCase().contains(query.toLowerCase()) ||
              user.email.toLowerCase().contains(query.toLowerCase()))
      );
    }
  }

  Future<void> fetchPendingRequests() async {
    try {
      final String userId = authService.currentUser.value!.id;
      final response = await _supabase
          .from('friendships')
          .select('id, requester:profiles!requester_id(*)')
          .eq('receiver_id', userId)
          .eq('status', 'pending');

      pendingRequests.assignAll(List<Map<String, dynamic>>.from(response));
    } catch (e) {
      debugPrint("Error loading friend requests: $e");
    }
  }

  Future<void> acceptRequest(String friendshipId) async {
    try {
      AuthHelper.showLoading();
      await _supabase
          .from('friendships')
          .update({'status': 'accepted'})
          .eq('id', friendshipId);

      await fetchPendingRequests();
      await fetchFriendList();

      AuthHelper.hideLoading();
      AppAlerts.success(message: "Friend request accepted!");
    } catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: "Error: $e");
    }
  }

  Future<void> declineRequest(String friendshipId) async {
    try {
      AuthHelper.showLoading();
      await _supabase.from('friendships').delete().eq('id', friendshipId);
      await fetchPendingRequests();
      AuthHelper.hideLoading();
    } catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: "Error: $e");
    }
  }

  Future<void> unfriend(String friendId) async {
    try {
      AuthHelper.showLoading();
      final String userId = authService.currentUser.value!.id;

      await _supabase.from('friendships').delete().or(
          'and(requester_id.eq.$userId,receiver_id.eq.$friendId),and(requester_id.eq.$friendId,receiver_id.eq.$userId)');

      await fetchFriendList();
      AuthHelper.hideLoading();
      AppAlerts.success(message: "Unfriended successfully.");
    } catch (e) {
      AuthHelper.hideLoading();
      AppAlerts.error(message: "Error unfriending: $e");
    }
  }

  @override
  void onClose() {
    if (_realtimeChannel != null) {
      _supabase.removeChannel(_realtimeChannel!);
    }
    super.onClose();
  }
}