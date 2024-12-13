import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';

class ProfileImageApiService {
  static ProfileImageApiService? _instance;

  ProfileImageApiService._internal();

  static ProfileImageApiService getInstance() {
    _instance ??= ProfileImageApiService._internal();
    return _instance!;
  }

  Future? profileImageData(context, image) async {
    try {
      var response = await http.post(Uri.parse(AppApiUtils.signUpUrl), body: {
        "image": image,
        "fcm_token": UserDetails.userFcmToken,
      });
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        LocalDataSaver.saveUserPhoto(jsonResponse["image"]);
        await fetchDataSPreferences();
      } else {
        // AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      }
    } catch (e) {
      // AppSnackBarToast.buildShowSnackBar(context, "Something went wrong");
      return e;
    }
  }
}
