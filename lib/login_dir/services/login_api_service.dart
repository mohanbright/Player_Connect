// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:player_connect/shared/auth/is_user_online.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class LoginApiService {
  static LoginApiService? _instance;

  LoginApiService._internal();

  static LoginApiService getInstance() {
    _instance ??= LoginApiService._internal();
    return _instance!;
  }

  getFcmToken() async {
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken().then((value) async => {
          LocalDataSaver.saveUserFcmToken(value),
          await fetchDataSPreferences(),
          print("==========$value"),
        });
  }

  Future loginData(context, email, password) async {
    try {
      await getFcmToken();
      var response = await http.post(
        Uri.parse(AppApiUtils.loginUrl),
        body: {
          "email": email,
          "password": password,
          "deviceToken": UserDetails.userFcmToken.toString()
          // "fcm_id": "1234567890",
        },
      );
      final jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        pageSelected = 0;
        print('Device token :- ${UserDetails.userFcmToken.toString()}');
        // print(jsonResponse);
        print(jsonResponse["body"]["token"]);
        LocalDataSaver.saveUserID(jsonResponse["body"]["id"].toString());
        LocalDataSaver.saveUserFirstName(
            jsonResponse["body"]["first_name"].toString());
        LocalDataSaver.saveUserLastName(
            jsonResponse["body"]["last_name"].toString());
        LocalDataSaver.saveUserAuthToken(
            jsonResponse["body"]["token"].toString());
        LocalDataSaver.saveUserEmail(email.toString());
        LocalDataSaver.saveUserPassword(password.toString());
        LocalDataSaver.saveUserPhone(jsonResponse["body"]["phone"].toString());
        LocalDataSaver.saveUserLatitude(jsonResponse["body"]["latitude"]);
        LocalDataSaver.saveUserLongitude(jsonResponse["body"]["longitude"]);
        LocalDataSaver.saveUserIsAppNotify(
            jsonResponse["body"]["isNotification"] == 1 ? true : false);
        LocalDataSaver.saveUserGender(
            jsonResponse["body"]["gender"].toString());
        LocalDataSaver.saveUserDob(jsonResponse["body"]["dob"]);
        LocalDataSaver.saveUserHeight(jsonResponse["body"]["height"]);
        LocalDataSaver.saveUserLocation(jsonResponse["body"]["city"]);
        LocalDataSaver.saveUserInfo(jsonResponse["body"]["about"]);
        LocalDataSaver.saveUserDesPart(jsonResponse["body"]["desired_partner"]);
        LocalDataSaver.saveUserPlayingStyle(
            jsonResponse["body"]["playingstyle"]);
        LocalDataSaver.saveUserCountryFlag(
            jsonResponse["body"]["country_flag"]);
        LocalDataSaver.saveUserIsUtr(
            jsonResponse["body"]["ratingtype"] == 0 ? true : false);
        LocalDataSaver.saveUserCountryName(
            jsonResponse["body"]["country"].toString());
        LocalDataSaver.saveUserCountryFlag(
            jsonResponse["body"]["country_flag"].toString());
        LocalDataSaver.saveUserPhoto(
            "${AppApiUtils.imageUrl}/${jsonResponse["body"]["images"]}");
        LocalDataSaver.saveUserName(
            "${jsonResponse["body"]["first_name"]} ${jsonResponse["body"]["last_name"]}");
        LocalDataSaver.saveUserLogData(true);
        await fetchDataSPreferences();
        await UserOnlineApiService.getInstance().isUserOnline(1);
        AppSnackBarToast.buildShowSnackBar(context, "User login successfully");
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.dashBoardPage, (route) => false);
        return true;
      } else if (jsonResponse["message"].toString() == "email does not exits") {
        print(response.body);
        AppSnackBarToast.buildShowSnackBar(context, "Email does not exits");
        return [];
      } else if (response.statusCode == 401) {
        AppSnackBarToast.buildShowSnackBar(context, "Invalid Credentials");
        return [];
      } else if (jsonResponse["message"] == "Incorrect email or password") {
        // print("response.statusCode:::::${response.body}");
        AppSnackBarToast.buildShowSnackBar(
            context, "Incorrect email or password");
        return [];
      } else {
        // print("response.statusCode::${response.body}");
        AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
        return [];
      }
    } catch (e) {
      print(e);
      AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      return [];
    }
  }







  Future? loginSocialData(context, socialType, socialId, email) async {
    try {
      getFcmToken();

      print(
          'Type Social : $socialType , Social Id : $socialId , Email : $email');

      print(socialType +
          " " +
          socialId +
          " " +
          email +
          " " +
          UserDetails.userFcmToken.toString());

      var response = await http.post(
        Uri.parse(AppApiUtils.socialLoginReq),
        body: {
          "social_type": socialType.toString(),
          "social_id": socialId.toString(),
          "email": email.toString(),
          "deviceToken": UserDetails.userFcmToken.toString(),
        },
      );
      final jsonResponse = jsonDecode(response.body);
      print("loginSocialData Login::${response.body}");

      if (response.statusCode == 200) {
        print("TOken Social :- ${UserDetails.userFcmToken.toString()}");
        print('jsonResponse : Social : $jsonResponse');
        print("jsonResponse:::${jsonResponse["body"]["deviceToken"]}");
        LocalDataSaver.saveUserID(jsonResponse["body"]["id"].toString());
        LocalDataSaver.saveUserFirstName(
            jsonResponse["body"]["first_name"].toString());
        LocalDataSaver.saveUserLastName(
            jsonResponse["body"]["last_name"].toString());
        LocalDataSaver.saveUserAuthToken(
            jsonResponse["body"]["token"].toString());
        LocalDataSaver.saveUserEmail(email.toString());
        LocalDataSaver.saveUserPhone(jsonResponse["body"]["phone"].toString());
        LocalDataSaver.saveUserLatitude(jsonResponse["body"]["latitude"]);
        LocalDataSaver.saveUserLongitude(jsonResponse["body"]["longitude"]);

        LocalDataSaver.saveUserIsAppNotify(
            jsonResponse["body"]["isNotification"] == 1 ? true : false);
        LocalDataSaver.saveUserGender(
            jsonResponse["body"]["gender"].toString());
        LocalDataSaver.saveUserDob(jsonResponse["body"]["dob"]);
        LocalDataSaver.saveUserHeight(jsonResponse["body"]["height"]);
        LocalDataSaver.saveUserLocation(jsonResponse["body"]["city"]);
        LocalDataSaver.saveUserInfo(jsonResponse["body"]["about"]);
        LocalDataSaver.saveUserDesPart(jsonResponse["body"]["desired_partner"]);
        LocalDataSaver.saveUserPlayingStyle(
            jsonResponse["body"]["playingstyle"]);
        LocalDataSaver.saveUserCountryFlag(
            jsonResponse["body"]["country_flag"]);
        LocalDataSaver.saveUserIsUtr(
            jsonResponse["body"]["ratingtype"] == 0 ? true : false);
        LocalDataSaver.saveUserCountryName(
            jsonResponse["body"]["country"].toString());
        LocalDataSaver.saveUserCountryFlag(
            jsonResponse["body"]["country_flag"].toString());
        LocalDataSaver.saveUserPhoto(
            "${AppApiUtils.imageUrl}/${jsonResponse["body"]["images"]}");
        LocalDataSaver.saveUserName(
            "${jsonResponse["body"]["first_name"]} ${jsonResponse["body"]["last_name"]}");
        LocalDataSaver.saveUserLogData(true);
        await fetchDataSPreferences();
        await UserOnlineApiService.getInstance().isUserOnline(1);
        AppSnackBarToast.buildShowSnackBar(context, "User login successfully");
        print(UserDetails.userAuthToken);
        pageSelected = 0;
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.dashBoardPage, (route) => false);
        return true;
      } else {
        print("loginSocialData::${response.body}");
        // Navigator.pushNamed(context, AppRoutes.verifiedPage);
        AppSnackBarToast.buildShowSnackBar(context, "Please SignUp first!");
        return;
      }
    } catch (e) {
      print("loginSocialData::$e");

      AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      return e;
    }
  }
}
