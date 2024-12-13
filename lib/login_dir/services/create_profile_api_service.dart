// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:player_connect/login_dir/provider/create_profile_provider.dart';
import 'package:player_connect/login_dir/services/login_api_service.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:provider/provider.dart';

class CreateProfileApiService {
  static CreateProfileApiService? _instance;

  CreateProfileApiService._internal();

  static CreateProfileApiService getInstance() {
    _instance ??= CreateProfileApiService._internal();
    return _instance!;
  }

  Future? createProfile(
    context,
    String fName,
    String lName,
    String email,
    String phone,
    File? image,
    String about,
    String dob,
    String height,
    String password,
    int gender,
    String city,
    String country,
    String countryCode,
    String countryFlag,
    int ratingType,
    String rating,
    int locationRange,
    String desPartner,
    String playingStyle,
    String domHand,
    String socialType,
    String socialId,
  ) async {
    try {
      final url = Uri.parse(AppApiUtils.signUpUrl);
      final formData = http.MultipartRequest('POST', url);

      if (image != null) {
        formData.files
            .add(await http.MultipartFile.fromPath('images', image.path));
      }

      formData.fields.addAll({
        "first_name": fName,
        "last_name": lName,
        "email": email,
        "phone": phone,
        "dob": dob,
        "height": height,
        "country": country,
        "country_code": countryCode,
        "country_flag": countryFlag,
        "password": password.isEmpty ? "38494032" : password,
        "role": "1",
        "gender": gender.toString(),
        "rating": rating,
        "city": city,
        "about": about,
        "desired_partner": desPartner,
        "playingstyle": playingStyle,
        "dominnant_hand": domHand,
        "location_range": locationRange.toString(),
        "ratingtype": ratingType.toString(),
        "latitude": UserDetails.userLatitude.toString(),
        "longitude": UserDetails.userLongitude.toString(),
        "deviceToken": UserDetails.userFcmToken.toString(),
        "social_type": socialType,
        "social_id": socialId,
      });

      final response = await http.Response.fromStream(await formData.send());

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        pageSelected = 0;
        print('Social Type now :- $socialType');

        if (socialType != '0' &&
            socialType != '1' &&
            socialType != '2' &&
            socialType != '3') {
          await LoginApiService.getInstance()
              .loginData(context, email, password);
        } else {
          await LoginApiService.getInstance()
              .loginSocialData(context, socialType, socialId, email);
        }
        Provider.of<CreateProfileProvider>(context, listen: false).clearData();
      } else if (jsonResponse["message"].toString() ==
          "Please used another number this number is already exists") {
        AppSnackBarToast.buildShowSnackBar(
            context, "Please use another number. This number already exists.");
      } else if (jsonResponse["message"].toString() == "Email Already exists") {
        AppSnackBarToast.buildShowSnackBar(
            context, "Please use another email. This email already exists.");
      } else {
        AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
        // AppSnackBarToast.buildShowSnackBar(context, "Login using Social Now");
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => const SignUpPage()));
      }
    } catch (e) {
      print("Error: $e");
      AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      // AppSnackBarToast.buildShowSnackBar(context, "Login using Social Now");
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => const SignUpPage()));
      return e;
    }
  }
}
