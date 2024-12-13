// ignore_for_file: unused_local_variable, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:player_connect/login_dir/provider/create_profile_provider.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:provider/provider.dart';

class SignUpApiService {
  static SignUpApiService? _instance;

  SignUpApiService._internal();

  static SignUpApiService getInstance() {
    _instance ??= SignUpApiService._internal();
    return _instance!;
  }

  Future<void> loginSocialData(
      BuildContext context, String socialType, String socialId, email) async {
    try {
      var response = await http.post(
        Uri.parse(AppApiUtils.socialLoginReq),
        body: {
          "social_type": socialType,
          "social_id": socialId,
          "role": "1",
          "email": email,
          "deviceToken": UserDetails.userFcmToken,
        },
      );

      final jsonResponse = jsonDecode(response.body);
      print("loginSocialData SignUp::${response.body}");
      if (response.statusCode == 200) {
        bool emailExists = jsonResponse['email'] ?? false;
        if (emailExists) {
          print("loginSocialData: body: ${response.body}");
          AppSnackBarToast.buildShowSnackBar(
              context, "User login successfully");
          Navigator.pushNamed(context, AppRoutes.dashBoardPage);
        } else {
          print("loginSocialData::::::: ${response.body}");
          Provider.of<CreateProfileProvider>(context, listen: false)
            ..emailController.text = email
            ..socialId = socialId;
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.verifiedPage,
            (route) => false,
            arguments: {
              'email': email,
              'socialId': socialId,
              'socialType': socialType,
            },
          );
        }
      } else {
        print("loginSocialData::::::: ${response.body}");
        Provider.of<CreateProfileProvider>(context, listen: false)
          ..emailController.text = email
          ..socialId = socialId;
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.verifiedPage,
          (route) => false,
          arguments: {
            'email': email,
            'socialId': socialId,
            'socialType': socialType,
          },
        );
      }
    } catch (e) {
      print("loginSocialData: error: $e");
      AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
    }
  }
}
