import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/player_dir/model/players_list_model.dart';
import 'package:player_connect/home_dir/player_dir/services/connect_api_service.dart';
import 'package:player_connect/home_dir/player_dir/services/deny_request_api_service.dart';
import 'package:player_connect/home_dir/player_dir/services/filter_api_service.dart';
import 'package:player_connect/home_dir/player_dir/services/player_list_api_service.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';

class PlayerProvider extends ChangeNotifier {
  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  List<PlayersListModelList>? getPlayersList = <PlayersListModelList>[];

  int tabWidget = 1;

  List utrList = [
    7.6,
    13,
    13,
    13,
    13,
  ];

  List imgList = [
    AppImages.playerRecc,
  ];
  List nameList = [
    "Doris Edwards",
    "Steve Jones",
    "Lori Anderson",
    "Mark Torres",
    "Earl Taylor",
    "Doris Edwards",
    "Steve Jones",
    "Lori Anderson",
    "Mark Torres",
    "Earl Taylor",
  ];

  List addressList = [
    "New Lamont, DE",
  ];
  List pointList = [
    8.0,
  ];
  List shortNameList = [
    "UTR",
  ];
  List btnList = [
    "Connect",
    "Connect",
    "Connect",
    "Connect",
    "Connect",
    "Connect",
    "Connect",
    "Connect",
    "Connect",
    "Connect",
  ];

  Widget buildText(text) {
    return Text(text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppFonts.mazzardFont(TextStyle(
            fontSize: AppFontSize.font10,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryColorBlack)));
  }

/* ==============================================Get Players List Api================================================*/
  Future? getProfileData(context) async {
    isLoading = true;
    notifyListeners();
    getPlayersList = await GetPlayersListApiService.getInstance()
        .getPlayersList(context)!
        .then((value) {
      notifyListeners();
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
    return getPlayersList ?? [];
  }
  /* ==============================================Connect Player Api================================================*/

  Future? connectPlayer(context) async {
    isLoading = true;
    notifyListeners();
    await ConnectPlayerApiService.getInstance()
        .connectPlayer(context, 1)!
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

  /* ==============================================Deny Request Api================================================*/

  Future? denyRequest(context) async {
    isLoading = true;
    notifyListeners();
    await DenyRequestApiService.getInstance()
        .denyRequest(context)!
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
  /* ==============================================Delete Connection Request Api================================================*/

  Future? deleteConnectionRequest(context) async {
    isLoading = true;
    notifyListeners();
    await DenyRequestApiService.getInstance()
        .denyRequest(context)!
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
}
