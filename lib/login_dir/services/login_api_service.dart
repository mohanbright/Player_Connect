// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';

class LoginApiService {
  static LoginApiService? _instance;

  LoginApiService._internal();

  static LoginApiService getInstance() {
    _instance ??= LoginApiService._internal();
    return _instance!;
  }
/* ==============================================Login User Api================================================*/

  Future loginData(context, email, password) async {
    try {
      // var response = await http.post(Uri.parse(AppApiUtils.loginUrl), body: {
      var response = await http.post(
          Uri.parse("https://stagingapi.guardwatch.net/api/login"),
          body: {
            "email": email,
            "password": password,
            // "fcm_id": UserDetails.userFcmToken,
            "fcm_id": "1234567890-=",
          });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        LocalDataSaver.saveUserAuthToken(jsonResponse["data"]["token"]);
        LocalDataSaver.saveUserEmail(email);
        LocalDataSaver.saveUserPassword(password);
        LocalDataSaver.saveUserLogData(true);
        await fetchDataSPreferences();
        print(UserDetails.userAuthToken);
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strUserLoginSuccess);
        return true;
      } else if (response.statusCode == 401) {
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strInvalidCredentials);
        return [];
      } else {
        print(response.statusCode);
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strSomethingWrong);
        return [];
      }
    } catch (e) {
      AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return [];
    }
  }
}
