// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class NewPassApiService {
  static NewPassApiService? _instance;

  NewPassApiService._internal();

  static NewPassApiService getInstance() {
    _instance ??= NewPassApiService._internal();
    return _instance!;
  }

  Future? updatePassword(context, password) async {
    try {
      final Map<String, dynamic> requestData = {
        "password": password,
      };

      final http.Response response = await http.post(
        Uri.parse(AppApiUtils.changePassReq),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        AppSnackBarToast.buildShowSnackBar(
            context, "Password Update Successfully");
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.loginPage, (route) => false);
      } else {
        AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      }
    } catch (e) {
      AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      return e;
    }
  }
}
