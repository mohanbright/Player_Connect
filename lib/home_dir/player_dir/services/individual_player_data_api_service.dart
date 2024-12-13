import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/home_dir/player_dir/page/individual_profile_model.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:provider/provider.dart';

class GetIndividualPlayersListApiService {
  static GetIndividualPlayersListApiService? _instance;

  GetIndividualPlayersListApiService._internal();

  static GetIndividualPlayersListApiService getInstance() {
    _instance ??= GetIndividualPlayersListApiService._internal();
    return _instance!;
  }

/* ==============================================Get Players List Api================================================*/

  List<IndividualPlayersBodyData> getPlayerList = [];

  Future<List<IndividualPlayersBodyData>> getIndividualPlayersList(
      context, id) async {
    try {
      var response = await http.get(
        Uri.parse("${AppApiUtils.viewUserAccountReq}/$id"),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          // 'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        IndividualPlayersModelList individualPlayersModelList =
            IndividualPlayersModelList.fromJson(jsonResponse);
        // List<IndividualPlayerModelBody> list = playersListModel.body!;
        // final allData=playersListModel.body!;
        // getPlayerList.add(allData);
        getPlayerList.add(individualPlayersModelList.body!);
        // print(jsonResponse);
        // print(getPlayerList);
        Provider.of<PlayerProvider>(context, listen: false).isLoading = false;
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
