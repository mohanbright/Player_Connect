import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/home_dir/player_dir/model/players_list_model.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class DenyRequestApiService {
  static DenyRequestApiService? _instance;

  DenyRequestApiService._internal();

  static DenyRequestApiService getInstance() {
    _instance ??= DenyRequestApiService._internal();
    return _instance!;
  }

/* ==============================================Deny Request Api================================================*/

  Future? denyRequest(context) async {
    try {
      var response = await http.post(
        Uri.parse(AppApiUtils.denyRequestUrl),
        headers: {
          "auth_token": UserDetails.userAuthToken!,
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
