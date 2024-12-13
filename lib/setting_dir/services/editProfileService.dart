import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:player_connect/home_dir/my_profile_dir/provider/my_profile_provider.dart';
import 'package:player_connect/home_dir/player_dir/model/players_list_model.dart';
import 'package:player_connect/home_dir/player_dir/model/searchUserModel.dart';
import 'package:player_connect/setting_dir/model/editProfileModel.dart';
import 'package:player_connect/setting_dir/provider/edit_profile_provider.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:provider/provider.dart';

class EditProfileService {
  static EditProfileService? _instance;

  EditProfileService._internal();

  static EditProfileService getInstance() {
    _instance ??= EditProfileService._internal();
    return _instance!;
  }

/* ==============================================Search Player Api================================================*/
  bool isSuccess = false;

  Future editProfile(
    context,
    index,
    firstName,
    lastName,
    email,
    country,
    phone,
    File images,
    dob,
    height,
    countryFlag,
    gender,
    ratingtype,
    rating,
    city,
    about,
    desiredPartner,
    plalingstyle,
    dominnantHand,
    locationRange,
  ) async {
    try {
      // print(images.path.toString());
      // print(images.path.toString()=="null");
      final url = Uri.parse(AppApiUtils.editUserProfileReq);
      final formData = http.MultipartRequest('POST', url);
      images.path.toString() == "null"
          ? null
          : formData.files
              .add(await http.MultipartFile.fromPath('images', images.path));
      formData.headers.addAll({
        'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
      });
      formData.fields.addAll(
        {
          "first_name": firstName.toString(),
          "last_name": lastName,
          "phone": phone.toString(),
          "dob": dob.toString(),
          "height": height.toString(),
          "country": country.toString(),
          "country_flag": countryFlag.toString(),
          "gender": gender.toString(),
          "rating": rating,
          "city": city.toString(),
          "about": about.toString(),
          "desired_partner": desiredPartner.toString(),
          "playingstyle": plalingstyle.toString(),
          "dominnant_hand": dominnantHand.toString(),
          "location_range": locationRange.toString(),
          "ratingtype": ratingtype.toString(),
        },
      );
      final response = await http.Response.fromStream(await formData.send());

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        EditProfileModel editProfileModel =
            EditProfileModel.fromJson(jsonResponse);
        EditProfileModelBody editProfileModelBody = editProfileModel.body!;

        LocalDataSaver.saveUserID(editProfileModelBody.id.toString());
        LocalDataSaver.saveUserFirstName(
            editProfileModelBody.firstName.toString());
        LocalDataSaver.saveUserLastName(
            editProfileModelBody.lastName.toString());
        LocalDataSaver.saveUserEmail(editProfileModelBody.email.toString());
        LocalDataSaver.saveUserPhone(editProfileModelBody.phone.toString());
        LocalDataSaver.saveUserLatitude(
            editProfileModelBody.latitude.toString());
        LocalDataSaver.saveUserLongitude(
            editProfileModelBody.longitude.toString());
        LocalDataSaver.saveUserIsAppNotify(
            editProfileModelBody.isNotification == 1 ? true : false);
        LocalDataSaver.saveUserGender(editProfileModelBody.gender.toString());
        LocalDataSaver.saveUserDob(editProfileModelBody.dob.toString());
        LocalDataSaver.saveUserHeight(editProfileModelBody.height.toString());
        LocalDataSaver.saveUserLocation(editProfileModelBody.city.toString());
        LocalDataSaver.saveUserInfo(editProfileModelBody.about.toString());
        LocalDataSaver.saveUserDesPart(
            editProfileModelBody.desiredPartner.toString());
        LocalDataSaver.saveUserPlayingStyle(
            editProfileModelBody.playingstyle.toString());
        LocalDataSaver.saveUserCountryFlag(
            editProfileModelBody.countryFlag.toString());
        LocalDataSaver.saveUserIsUtr(
            editProfileModelBody.ratingtype == 0 ? true : false);
        LocalDataSaver.saveUserCountryName(
            editProfileModelBody.country.toString());
        LocalDataSaver.saveUserPhoto(
            "${AppApiUtils.imageUrl}/${editProfileModelBody.images.toString()}");
        LocalDataSaver.saveUserName(
            "${editProfileModelBody.firstName} ${editProfileModelBody.lastName}");
        Provider.of<MyProfileProvider>(context, listen: false)
            .fetchUserProfile();
        await fetchDataSPreferences();
        Provider.of<EditProfileProvider>(context, listen: false)
            .isPhotoChanged = false;
        Provider.of<EditProfileProvider>(context, listen: false).userImg =
            "${AppApiUtils.imageUrl}/${editProfileModelBody.images.toString()}";
        AppSnackBarToast.buildShowSnackBar(
            context, "Edit Profile Successfully");
        if (index == 5) {
          pageSelected = 0;
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.dashBoardPage, (route) => false);
        }
      } else {
        print("eeerreee:${response.body}");
        AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      }
    } catch (e) {
      print("eeeeee:$e");
      AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      return e;
    }
  }
}

// final url = Uri.parse(AppApiUtils.editUserProfileReq);
// final formData = http.MultipartRequest('POST', url);

// formData.headers.addAll({
//   'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
// 'Content-Type': 'application/json',
// });
