import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:player_connect/setting_dir/services/deleteAcc_api_service.dart';
import 'package:player_connect/setting_dir/services/logOut_api_service.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SettingPageProvider extends ChangeNotifier {
  bool isLoading = false;
  String selectedValue = AppStrings.strSomethingBroken;
  TextEditingController reasonQueryController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Future? logOutReqPlayer(context) async {
    isLoading = true;
    notifyListeners();
    // _googleSignIn.signOut();
    LogOutApiService.getInstance().logOutData(context)?.whenComplete(() {
      isLoading = false;
      notifyListeners();
      notifyListeners();
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
  }







  Future<void> signOutApple() async {
    try {
      await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      ).catchError((error) {
        print('Apple sign out failed: $error');
      });

      print('Apple Sign-Out Process Done');
    } catch (e) {
      print('Error during Apple sign out: $e');
    }
  }




  Future? deleteAccountReq(context) async {
    isLoading = true;
    notifyListeners();
    await DeleteAccountApiService.getInstance()
        .deleteAccountReq(
            context,
            selectedValue == AppStrings.strOther
                ? reasonQueryController.text
                : selectedValue)
        ?.whenComplete(() {
      isLoading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
  }
}
