import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/home_dir/player_dir/model/searchUserModel.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class SearchPlayerApiService {
  static SearchPlayerApiService? _instance;

  SearchPlayerApiService._internal();

  static SearchPlayerApiService getInstance() {
    _instance ??= SearchPlayerApiService._internal();
    return _instance!;
  }

/* ==============================================Search Player Api================================================*/

  List<SearchUserModelBody> getSearchPlayerList = [];

  Future<List<SearchUserModelBody>> searchPlayers(
    context, {
    String? playerName,
    int? utrRating,
    int? ntrpRating,
    int? distanceFromMe,
  }) async {
    try {
      // print(playerName.toString().isEmpty);
      // print(ntrpRating ?? utrRating);
      // print(utrRating == null ?1:0);
      final Map<String, dynamic> requestData = playerName.toString() == ''
          ? {
              "latitude": UserDetails.userLatitude,
              "longitude": UserDetails.userLongitude,
              "location_range": distanceFromMe,
              "rating": ntrpRating ?? utrRating,
              "ratingtype": utrRating == null ? 1 : 0,
            }
          : {
              "full_name": playerName,
            };

      final http.Response response = await http.post(
        Uri.parse(AppApiUtils.searchPlayerUrl),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData),
      );
      // print(response.body);
      // print("searchPlayers.statusCode:${response.statusCode}");
      // print("searchPlayers.body:${response.body}");
      if (response.statusCode == 200) {
        getSearchPlayerList.clear();
        final responseData = json.decode(response.body);
        SearchUserModel playersListModel =
            SearchUserModel.fromJson(responseData);
        List<SearchUserModelBody> list = playersListModel.body!;
        getSearchPlayerList.addAll(list);
        // print("response.statusCode:${getSearchPlayerList.length}");
        for (int i = 0; i < getSearchPlayerList.length; i++) {
          if (getSearchPlayerList[i].id.toString() == UserDetails.userID) {
            getSearchPlayerList.removeAt(i);
          } else if (getSearchPlayerList[i].receiverStatus1 == 3 ||
              getSearchPlayerList[i].receiverStatus2 == 3 ||
              getSearchPlayerList[i].senderStatus1 == 3 ||
              getSearchPlayerList[i].senderStatus2 == 3) {
            getSearchPlayerList.removeAt(i);
          }
        }

        return getSearchPlayerList;
      } else {
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strFailedLoadPlayerList);
      }
    } catch (e) {
      print("''''''''$e");

      AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return [];
    }
    return getSearchPlayerList;
  }
}
