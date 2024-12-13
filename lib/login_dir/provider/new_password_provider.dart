
import 'package:flutter/material.dart';
import 'package:player_connect/login_dir/services/new_pass_api_service.dart';

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

  updatePassword(context) async {
    await NewPassApiService.getInstance()
        .updatePassword(context, passwordController.text.trim())!
        .whenComplete(() {
      notifyListeners();
    });
  }
}
