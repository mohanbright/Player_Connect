import 'package:flutter/material.dart';

class ChangePassPageProvider extends ChangeNotifier {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isShowCurrentPassword = true;
  bool isShowNewPassword = true;
  bool isShowConfirmPassword = true;

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
}
