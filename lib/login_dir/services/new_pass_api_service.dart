// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class NewPassApiService {
  static NewPassApiService? _instance;

  NewPassApiService._internal();

  static NewPassApiService getInstance() {
    _instance ??= NewPassApiService._internal();
    return _instance!;
  }
/* ==============================================New Password Api================================================*/

  Future? newPasswordData(context, email, password) async {
    try {
      var response = await http.post(Uri.parse(AppApiUtils.signUpUrl), body: {
        "email": email,
        "password": password,
        "fcm_token": UserDetails.userFcmToken,
      });
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
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
