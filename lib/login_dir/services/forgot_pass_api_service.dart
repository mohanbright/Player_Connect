// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class ForgotApiService {
  static ForgotApiService? _instance;

  ForgotApiService._internal();

  static ForgotApiService getInstance() {
    _instance ??= ForgotApiService._internal();
    return _instance!;
  }
/* ==============================================Forgot Password Api================================================*/

  Future? forgotData(context, email) async {
    try {
      var response = await http.post(Uri.parse(AppApiUtils.signUpUrl), body: {
        "email": email,
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
