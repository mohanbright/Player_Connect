// ignore_for_file: unused_local_variable, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:player_connect/shared/auth/is_user_online.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';

class LogOutApiService {
  static LogOutApiService? _instance;

  LogOutApiService._internal();

  static LogOutApiService getInstance() {
    _instance ??= LogOutApiService._internal();
    return _instance!;
  }

  Future? logOutData(context) async {
    try {
      var response = await http.post(
        Uri.parse(AppApiUtils.logOutReq),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        await UserOnlineApiService.getInstance().isUserOnline(0);
        final jsonResponse = jsonDecode(response.body);
        LocalDataSaver.saveUserLogData(false);
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strLogOutSuccess);
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.loginPage, (route) => false);
        removeDataSPreferences();
        clearDataSPreferences();
      } else {
        print(response.body);
        AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      }
    } catch (e) {
      print(e);
      AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      return e;
    }
  }
}
