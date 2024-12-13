import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/home_dir/player_dir/model/recommended_model.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class RecommendedPlayerApiService {
  static RecommendedPlayerApiService? _instance;

  RecommendedPlayerApiService._internal();

  static RecommendedPlayerApiService getInstance() {
    _instance ??= RecommendedPlayerApiService._internal();
    return _instance!;
  }

/* ==============================================Search Player Api================================================*/

  List<RecommendedUserModelBody> getRecommendedPlayerList = [];

  Future<List<RecommendedUserModelBody>> recommendedPlayers() async {
    try {
      final http.Response response = await http.post(
        Uri.parse(AppApiUtils.recommendedListApi),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          // 'Content-Type': 'application/json',
        },
      );
      // print(response.body);
      // print("recommendedPlayers.statusCode:${response.statusCode}");
      // print("recommendedPlayers.body:${response.body}");
      if (response.statusCode == 200) {
        // getRecommendedPlayerList.clear();
        final responseData = json.decode(response.body);
        RecommendedUserModel playersListModel =
            RecommendedUserModel.fromJson(responseData);
        print(
            "getRecommendedPlayerListLength:::::${playersListModel.body!.length}");

        List<RecommendedUserModelBody> list = playersListModel.body!;
        getRecommendedPlayerList.addAll(list);

        for (int i = 0; i < getRecommendedPlayerList.length; i++) {
          if (getRecommendedPlayerList[i].id.toString() ==
              UserDetails.userID.toString()) {
            getRecommendedPlayerList.removeAt(i);
          }
        }
        print(
            "getRecommendedPlayerListLength::${getRecommendedPlayerList.length}");
        return getRecommendedPlayerList;
      } else {
        // AppSnackBarToast.buildShowSnackBar(
        //     context, AppStrings.strSomethingWrong);
      }
    } catch (e) {
      print("''''''''$e");

      // AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return [];
    }
    return getRecommendedPlayerList;
  }
}
