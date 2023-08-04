import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';

class AppSnackBarToast {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      buildShowSnackBar(BuildContext context, title) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(title,
            style: AppFonts.poppinsFont(TextStyle(
                color: AppColors.primaryColorBlue,
                fontWeight: FontWeight.w600,
                fontSize: AppFontSize.font14))),
        backgroundColor: AppColors.primaryColorSkyBlue,
      ),
    );
  }
}
