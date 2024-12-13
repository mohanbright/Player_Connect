import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/home_dir/player_dir/model/players_list_model.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class GetPlayersListApiService {
  static GetPlayersListApiService? _instance;

  GetPlayersListApiService._internal();

  static GetPlayersListApiService getInstance() {
    _instance ??= GetPlayersListApiService._internal();
    return _instance!;
  }

/* ==============================================Get Players List Api================================================*/

  List<PlayersListModelListBody> getPlayerList = [];

  Future<List<PlayersListModelListBody>> getPlayersList() async {
    try {
      var response = await http.get(
        Uri.parse(AppApiUtils.getPlayerList),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          'Content-Type': 'application/json',
        },
      );
      // print("getPlayersList.body:${response.body}");
      if (response.statusCode == 200) {
        getPlayerList.clear();
        final jsonResponse = jsonDecode(response.body);
        PlayersListModelList playersListModel =
            PlayersListModelList.fromJson(jsonResponse);
        List<PlayersListModelListBody> list = playersListModel.body!;
        getPlayerList.addAll(list);
        for (int i = 0; i < getPlayerList.length; i++) {
          if (getPlayerList[i].id.toString() == UserDetails.userID ||getPlayerList[i].receiverStatus1 == 3 ||
              getPlayerList[i].receiverStatus2 == 3 ||
              getPlayerList[i].senderStatus1 == 3 ||
              getPlayerList[i].senderStatus2 == 3) {
            getPlayerList.removeAt(i);
          }
        }
        return getPlayerList;
      } else {
        // print(response.body);
        // AppSnackBarToast.buildShowSnackBar(
        //     context, AppStrings.strSomethingWrong);
        return [];
      }
    } catch (e) {
      print(e);

      // AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return [];
    }
  }
}
