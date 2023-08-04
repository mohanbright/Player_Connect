import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/home_dir/player_dir/model/players_list_model.dart';
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

  // Future<List<PlayersListModelList>> searchPlayers(
  Future<Object?> searchPlayers(context, String authToken, String playerName,
      double utrRating, double ntrpRating, String distanceFromMe) async {
    try {
      final Map<String, dynamic> filter = {
        'utr_rating': utrRating,
        'ntrp_rating': ntrpRating,
        'distance_from_me': distanceFromMe,
      };

      final Map<String, dynamic> requestData = {
        'auth_token': authToken,
        'player_name': playerName,
        'filter': filter,
      };

      final http.Response response = await http.post(
        Uri.parse(AppApiUtils.searchPlayerUrl),
        headers: {
          "auth_token": UserDetails.userAuthToken!,
        },
        body: json.encode(requestData),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData =
            json.decode(response.body)['players'];
        return responseData
            .map((playerData) => PlayersListModelList.fromJson(playerData))
            .toList();
      } else {
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strFailedLoadPlayerList);
      }
    } catch (e) {
      AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return e;
    }
    return null;
  }
}
