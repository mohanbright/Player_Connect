// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';

class AlertDialogWidget extends StatefulWidget {
  final provider;

  const AlertDialogWidget({Key? key, this.provider}) : super(key: key);

  @override
  State<AlertDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<AlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.strNtrpRating,
          textAlign: TextAlign.center,
          style: AppFonts.mazzardFont(TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColorBlue,
              fontSize: AppFontSize.font18))),
      content: Container(
        height: double.infinity,
        // Change as per your requirement
        width: MediaQuery.of(context).size.width,
        // Change as per your requirement
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: widget.provider.ntrpList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                setState(() {});
              },
              titleAlignment: widget.provider.ratingListIndex == index
                  ? ListTileTitleAlignment.top
                  : ListTileTitleAlignment.center,
              contentPadding: EdgeInsets.all(0),
              title: Text(AppStrings.strNtrp.toUpperCase(),
                  style: AppFonts.poppinsFont(TextStyle(
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColorBlack,
                      fontSize: AppFontSize.font14))),
              leading: Container(
                height: AppFontSize.font28,
                width: AppFontSize.font45,
                decoration: BoxDecoration(
                    color: widget.provider.ratingListIndex == index
                        ? AppColors.primaryColorBlue
                        : AppColors.primaryColorSkyBlue,
                    borderRadius: BorderRadius.circular(AppFontSize.font12)),
                child: Center(
                  child: Text(widget.provider.ntrpList[index].toString(),
                      style: AppFonts.poppinsFont(TextStyle(
                          fontWeight: FontWeight.w600,
                          color: widget.provider.ratingListIndex == index
                              ? AppColors.secondaryColorWhite
                              : AppColors.primaryColorBlue,
                          fontSize: AppFontSize.font12))),
                ),
              ),
              trailing: InkWell(
                onTap: () {
                  widget.provider.getRatingIndex(index);
                  setState(() {});
                },
                child: widget.provider.ratingListIndex == index
                    ? Icon(Icons.keyboard_arrow_up_outlined,
                        color: AppColors.secondaryColorBlack)
                    : Icon(Icons.keyboard_arrow_down_outlined,
                        color: AppColors.secondaryColorBlack),
              ),
              subtitle: widget.provider.ratingListIndex == index
                  ? Text(
                      widget.provider.descriptionList[0],
                      style: AppFonts.poppinsFont(TextStyle(
                          fontSize: AppFontSize.font14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryColorBlack)),
                    )
                  : null,
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: AppButtons.elevatedButton(
              AppStrings.strClose.toUpperCase(),
              AppFonts.poppinsFont(TextStyle(
                  fontSize: AppFontSize.font16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryColorWhite)),
              AppColors.primaryColorBlue),
        )
      ],
    );
  }
}
