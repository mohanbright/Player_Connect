import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/home_dir/player_dir/model/players_list_model.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class ConnectPlayerApiService {
  static ConnectPlayerApiService? _instance;

  ConnectPlayerApiService._internal();

  static ConnectPlayerApiService getInstance() {
    _instance ??= ConnectPlayerApiService._internal();
    return _instance!;
  }

/* ==============================================Connect Player Api================================================*/

  Future? connectPlayer(context, playerId) async {
    try {
      var response = await http.post(
        Uri.parse(AppApiUtils.playersDetailsUrl),
        headers: {
          "auth_token": UserDetails.userAuthToken!,
          "player_id": playerId,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final PlayersListModel user = PlayersListModel.fromJson(jsonResponse);
        return user;
      } else {
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strSomethingWrong);
      }
    } catch (e) {
      AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return e;
    }
  }
}
