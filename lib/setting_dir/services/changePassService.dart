import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:player_connect/home_dir/player_dir/model/players_list_model.dart';
import 'package:player_connect/home_dir/player_dir/model/searchUserModel.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class ChangePassService {
  static ChangePassService? _instance;

  ChangePassService._internal();

  static ChangePassService getInstance() {
    _instance ??= ChangePassService._internal();
    return _instance!;
  }

/* ==============================================Search Player Api================================================*/
  bool isSuccess = false;

  Future changePassReq(
    context,
    oldPass,
    newPass,
    confPass,
  ) async {
    try {
      final Map<String, dynamic> requestData = {
        "oldpassword": oldPass,
        "newpassword": newPass,
        "confirm_password": confPass,
      };

      final http.Response response = await http.put(
        Uri.parse(AppApiUtils.changePassReq),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData),
      );
      print("response.statusCode:${response.statusCode}");
      print("response.statusCode:${response.body}");
      if (response.statusCode == 200) {
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strNewPassChanged);
        // Navigator.pop(context);
        clearDataSPreferences();
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.loginPage, (route) => false);
        return true;
      } else if (response.statusCode == 400) {
        AppSnackBarToast.buildShowSnackBar(
            context, "Old password does not match");
        return false;
      } else {
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strSomethingWrong);
        return false;
      }
    } catch (e) {
      print("''''''''$e");

      AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return false;
    }
  }
}
