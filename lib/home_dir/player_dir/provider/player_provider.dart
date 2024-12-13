import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/player_dir/model/players_list_model.dart';
import 'package:player_connect/home_dir/player_dir/model/recommended_model.dart';
import 'package:player_connect/home_dir/player_dir/model/searchUserModel.dart';
import 'package:player_connect/home_dir/player_dir/page/individual_profile_model.dart';
import 'package:player_connect/home_dir/player_dir/services/block_user_service.dart';
import 'package:player_connect/home_dir/player_dir/services/response_request_api_service.dart';
import 'package:player_connect/home_dir/player_dir/services/filter_api_service.dart';
import 'package:player_connect/home_dir/player_dir/services/individual_player_data_api_service.dart';
import 'package:player_connect/home_dir/player_dir/services/player_list_api_service.dart';
import 'package:player_connect/home_dir/player_dir/services/recommended_player_api_service.dart';
import 'package:player_connect/home_dir/player_dir/services/search_player_api_service.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';

class PlayerProvider extends ChangeNotifier {
  int? selectedId;
  bool isLoading = false;
  bool isProfileLoading = false;
  TextEditingController searchController = TextEditingController();
  List<PlayersListModelListBody> getPlayersList = <PlayersListModelListBody>[];
  List<IndividualPlayersBodyData> getIndividualPlayersList =
      <IndividualPlayersBodyData>[];
  List<SearchUserModelBody> getSearchPlayersList = <SearchUserModelBody>[];

  // List<PlayersListModelListBody> getSearchedDataList = <PlayersListModelListBody>[];
  List<RecommendedUserModelBody> getRecommendedPlayersList =
      <RecommendedUserModelBody>[];

  int tabWidget = 1;
  bool isPlayerListLoading = false;
  bool isRecommendedListLoading = false;

  Widget buildText(text) {
    return Text(text,
        maxLines: 2,
        // overflow: TextOverflow.ellipsis,
        style: AppFonts.mazzardFont(TextStyle(
            fontSize: AppFontSize.font10,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryColorBlack)));
  }

/* ==============================================Get Players List Api================================================*/
  Future? getPlayerListData() async {
    isPlayerListLoading = true;
    getPlayersList.clear();
    getPlayersList = await GetPlayersListApiService.getInstance()
        .getPlayersList()
        .whenComplete(() {
      // isPlayerListLoading=false;
      notifyListeners();
    });
    isPlayerListLoading = false;
    notifyListeners();
  }

/* ==============================================Get Players Individual Api================================================*/
  Future? getIndividualProfileData(context, id) async {
    // isProfileLoading = true;
    notifyListeners();
    getIndividualPlayersList.clear();
    getIndividualPlayersList =
        await GetIndividualPlayersListApiService.getInstance()
            .getIndividualPlayersList(context, id);
    // isProfileLoading = false;
    notifyListeners();
  }

/* ==============================================Get Players Recommended Api================================================*/
  Future? getIRecommendedData() async {
    // isLoading = true;
    // notifyListeners();
    isRecommendedListLoading = true;
    getRecommendedPlayersList.clear();
    getRecommendedPlayersList = await RecommendedPlayerApiService.getInstance()
        .recommendedPlayers()
        .whenComplete(() {
      notifyListeners();
    });
    isRecommendedListLoading = false;
    notifyListeners();
    // isLoading = false;
  }

  /* ==============================================Connect Player Api================================================*/

  // Future? connectPlayer(context) async {
  //   isLoading = true;
  //   notifyListeners();
  //   await ConnectPlayerApiService.getInstance()
  //       .connectPlayer(context, 1)!
  //       .then((value) {
  //     notifyListeners();
  //   }).onError((error, stackTrace) {
  //     isLoading = false;
  //     notifyListeners();
  //   });
  //   isLoading = false;
  //   notifyListeners();
  //   return;
  // }

  Future? sendRequest(context, id, index, type) async {
    isLoading = true;
    isProfileLoading = true;
    notifyListeners();
    await RequestResponseApiService.getInstance()
        .sendRequest(context, id, index, type);
    isLoading = false;
    isProfileLoading = false;
    notifyListeners();
    return;
  }

  /* ==============================================Delete Connection Request Api================================================*/

  Future? deleteConnectionRequest(context, index, type, id) async {
    isLoading = true;
    isProfileLoading = true;

    notifyListeners();
    await RequestResponseApiService.getInstance()
        .deleteRequest(context, index, type, id);
    isLoading = false;
    isProfileLoading = false;
    notifyListeners();
    return;
  }

  /* ==============================================Filter Api ================================================*/

  Future? filterApi(context) async {
    isLoading = true;
    notifyListeners();
    await FilterApiService.getInstance()
        .filterApi(context, 1.1, 1, 12)!
        .then((value) {
      notifyListeners();
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
    return;
  }

  /* ==============================================Search Api ================================================*/

  Future? searchApi(context, {name, uRating, nRating, distance}) async {
    // isLoading = false;
    getSearchPlayersList.clear();
    notifyListeners();
    getSearchPlayersList = await SearchPlayerApiService.getInstance()
        .searchPlayers(context,
            playerName: name,
            utrRating: uRating == null ? null : int.parse(uRating.toString()),
            ntrpRating: nRating == null ? null : int.parse(nRating.toString()),
            distanceFromMe: distance);
    isLoading = false;
    notifyListeners();
    return;
  }

  Future? searchNameApi(context, {name}) async {
    // isLoading = false;
    getSearchPlayersList.clear();
    notifyListeners();

    getSearchPlayersList = await SearchPlayerApiService.getInstance()
        .searchPlayers(context, playerName: name);
    isLoading = false;
    notifyListeners();
    return;
  }

  Set<String> blockedUserIds = {};

  bool isUserBlocked(String userId) {
    return blockedUserIds.contains(userId);
  }

  void updateBlockedUsers(Set<String> newBlockedUserIds) {
    blockedUserIds = newBlockedUserIds;
    notifyListeners();
  }

  Future<void> toggleBlockStatus(BuildContext context, String userId) async {
    if (isUserBlocked(userId)) {
      await unblockUserRequest(context, userId);
    } else {
      await blockUserRequest(context, userId);
    }
    notifyListeners();
  }

  Future<void> blockUserRequest(
      BuildContext context, String blockUserId) async {
    print('Blocked User Id:- $blockUserId');
    isLoading = true;
    isProfileLoading = true;
    notifyListeners();
    await BlockUserApiService.getInstance().blockUser(context, blockUserId);
    blockedUserIds.add(blockUserId); // Add to blocked list
    isLoading = false;
    isProfileLoading = false;
    notifyListeners();
  }

  // Unblock a user
  Future<void> unblockUserRequest(
      BuildContext context, String unblockUserId) async {
    print('Unblocked User Id:- $unblockUserId');
    isLoading = true;
    isProfileLoading = true;
    notifyListeners();
    await BlockUserApiService.getInstance().unblockUser(context, unblockUserId);
    blockedUserIds.remove(unblockUserId); // Remove from blocked list
    isLoading = false;
    isProfileLoading = false;
    notifyListeners();
  }
}
