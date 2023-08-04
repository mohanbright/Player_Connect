// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:player_connect/login_dir/services/login_api_service.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowPassword = true;
  bool isLoading = false;

  setShowPassword() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }

  Future? login(context) async {
    isLoading = true;
    bool isLogin = false;
    notifyListeners();
    await LoginApiService.getInstance()
        .loginData(context, emailController.text.trim(),
            passwordController.text.trim())
        .then((value) {
      value == true ? isLogin = true : isLogin = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      isLoading = false;
      notifyListeners();
    });
    isLoading = false;
    notifyListeners();
    return isLogin;
  }
}
