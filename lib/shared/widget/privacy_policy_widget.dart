import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';

class PrivacyPolicyWidget extends StatefulWidget {
  const PrivacyPolicyWidget({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyWidget> createState() => _PrivacyPolicyWidgetState();
}

class _PrivacyPolicyWidgetState extends State<PrivacyPolicyWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.strPrivacyPolicy,
          textAlign: TextAlign.center,
          style: AppFonts.mazzardFont(TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColorBlue,
              fontSize: AppFontSize.font18))),
      content: SingleChildScrollView(
        child: Text(
            "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.\n\nNeque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.\n\nUt enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur?",
            style: AppFonts.mazzardFont(TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.secondaryColorBlack,
                fontSize: AppFontSize.font14))),
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: AppButtons.elevatedButton(
              AppStrings.strAgree.toUpperCase(),
              AppFonts.poppinsFont(TextStyle(
                  fontSize: AppFontSize.font14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryColorWhite)),
              AppColors.primaryColorBlue),
        )
      ],
    );
  }
}
