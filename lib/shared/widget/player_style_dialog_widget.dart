import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';

class PlayerStyleDialogWidget extends StatefulWidget {
  const PlayerStyleDialogWidget({Key? key}) : super(key: key);

  @override
  State<PlayerStyleDialogWidget> createState() =>
      _PlayerStyleDialogWidgetState();
}

class _PlayerStyleDialogWidgetState extends State<PlayerStyleDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.strPlayingStyle,
          textAlign: TextAlign.center,
          style: AppFonts.mazzardFont(TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColorBlue,
              fontSize: AppFontSize.font18))),
      content: SingleChildScrollView(
        child: Text(
            "This player is learning to judge where the oncoming ball is going and how much swing is needed to return it consistently. Movement to the ball and recovery are ofter not efficient. Can sustain a backcourt rally of slow pace with other players of similar ability and is beginning to develop stokes. This play is becoming more familiar with the basic positions for singles and doubles, and is ready to play social matches, leagues and low-level touraments.\n\nPotential limitations: grip weaknesses; limited swing and inconsistent toss on serve; limited transitions to the net.",
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
              AppStrings.strClose.toUpperCase(),
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
