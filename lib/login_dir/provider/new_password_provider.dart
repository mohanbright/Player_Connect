import 'package:flutter/material.dart';

class NewPasswordProvider extends ChangeNotifier {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isShowPassword = true;
  bool isShowConfirmPassword = true;
  setShowPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  setShowConfirmPassword() {
    isShowConfirmPassword = !isShowConfirmPassword;
    notifyListeners();
  }
}
