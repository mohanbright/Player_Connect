// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:player_connect/login_dir/provider/forgot_password_provider.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:provider/provider.dart';

class ForgotApiService {
  static ForgotApiService? _instance;

  ForgotApiService._internal();

  static ForgotApiService getInstance() {
    _instance ??= ForgotApiService._internal();
    return _instance!;
  }

  Future? getUserEmail(context, email) async {
    try {
      final Map<String, dynamic> requestData = {
        "email": email,
      };

      final http.Response response = await http.post(
        Uri.parse(AppApiUtils.forgotPasswordReq),
        // headers: {
        //   'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
        //   'Content-Type': 'application/json',
        // },
        body: json.encode(requestData),
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        Provider.of<ForgotPasswordProvider>(context, listen: false)
            .emailController
            .clear();
        Navigator.pushNamed(context, AppRoutes.newPasswordPage);
      } else {
        AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
        // print(response.body);
        return;
      }
    } catch (e) {
      AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      print("errror:::::$e");
      return e;
    }
  }
}
