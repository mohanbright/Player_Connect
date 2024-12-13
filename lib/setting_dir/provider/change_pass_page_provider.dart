import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/services/changePassService.dart';

class ChangePassPageProvider extends ChangeNotifier {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isShowCurrentPassword = true;
  bool isShowNewPassword = true;
  bool isShowConfirmPassword = true;
  bool isLoading = false;

  setShowCurrentPassword() {
    isShowCurrentPassword = !isShowCurrentPassword;
    notifyListeners();
  }

  setShowNewPassword() {
    isShowNewPassword = !isShowNewPassword;
    notifyListeners();
  }

  setShowConfirmPassword() {
    isShowConfirmPassword = !isShowConfirmPassword;
    notifyListeners();
  }

  changePass(context) async {
    isLoading = true;
    notifyListeners();
    await ChangePassService.getInstance()
        .changePassReq(
            context,
            currentPasswordController.text,
            newPasswordController.text.trim(),
            confirmPasswordController.text.trim())
        .whenComplete(() {
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
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
