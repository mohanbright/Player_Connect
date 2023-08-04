import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/home_dir/my_profile_dir/model/get_user_profile_model.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class GetProfileApiService {
  static GetProfileApiService? _instance;

  GetProfileApiService._internal();

  static GetProfileApiService getInstance() {
    _instance ??= GetProfileApiService._internal();
    return _instance!;
  }
/* ==============================================Get Profile Data Api================================================*/

  Future? getProfileData(context) async {
    try {
      var response = await http.get(
        Uri.parse(AppApiUtils.userProfileDetailsUrl),
        headers: {
          "auth_token": UserDetails.userAuthToken!,
          "user_id": UserDetails.userID!,
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final ProfileModel user = ProfileModel.fromJson(jsonResponse);

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
