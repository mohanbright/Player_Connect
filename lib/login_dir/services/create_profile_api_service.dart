// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';

class CreateProfileApiService {
  static CreateProfileApiService? _instance;

  CreateProfileApiService._internal();

  static CreateProfileApiService getInstance() {
    _instance ??= CreateProfileApiService._internal();
    return _instance!;
  }
/* ==============================================Create Profile Api================================================*/

  Future? createProfile(
    context,
    image,
    fName,
    lName,
    mobNo,
    about,
    gender,
    dob,
    age,
    height,
    cmHeight,
    city,
    country,
    countryFlag,
    isUtr,
    rating,
    drivDis,
    desPartner,
    playingStyle,
    domHand,
    authToken,
  ) async {
    try {
      var response = await http.post(Uri.parse(AppApiUtils.signUpUrl), body: {
        "image": image,
        "first_name": fName,
        "last_name": lName,
        "mobile_number": mobNo,
        "about": about,
        "gender": gender,
        "date_of_birth": dob,
        "age": age,
        "height": height,
        "cmHeight": cmHeight,
        "city": city,
        "country": country,
        "country_flag": countryFlag,
        "have_utr_rating": isUtr,
        "utr_rating": isUtr ? rating : null,
        "ntrp_rating": isUtr ? null : rating,
        "max_driving_distance": drivDis,
        "desired_partner": desPartner,
        "playing_style": playingStyle,
        "dominant_hand": domHand,
        "auth_token": authToken,
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
