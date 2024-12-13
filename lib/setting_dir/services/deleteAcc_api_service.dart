// ignore_for_file: unused_local_variable, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';

class DeleteAccountApiService {
  static DeleteAccountApiService? _instance;

  DeleteAccountApiService._internal();

  static DeleteAccountApiService getInstance() {
    _instance ??= DeleteAccountApiService._internal();
    return _instance!;
  }

  Future? deleteAccountReq(context, msg) async {
    try {
      var response = await http.delete(
        Uri.parse(AppApiUtils.deleteUserAccountReq),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken}',
        },
        body: {
          "delete_reason": msg.toString(),
          "email":UserDetails.userEmail.toString(),
        },
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        LocalDataSaver.saveUserLogData(false);
        removeDataSPreferences();
        clearDataSPreferences();
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strAccountDeleteSuccess);
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.loginPage, (route) => false);
      } else {
        // print(response.body);
        AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
        return;
      }
    } catch (e) {
      print("::::::$e");
      AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      return e;
    }
  }
}
