import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/my_profile_dir/model/get_user_profile_model.dart';
import 'package:player_connect/home_dir/my_profile_dir/services/my_profile_api_service.dart';

class MyProfileProvider extends ChangeNotifier {
  bool isLoading = false;
  List<ProfileModel>? getProfileDataList = <ProfileModel>[];

/* ==============================================Get Profile Data Api================================================*/
  Future? getProfileData(context) async {
    isLoading = true;
    notifyListeners();
    getProfileDataList = await GetProfileApiService.getInstance()
        .getProfileData(context)!
        .then((value) {
      notifyListeners();
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
    return getProfileDataList ?? [];
  }
}
