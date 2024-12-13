import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';

class PlayerStyleDialogWidget extends StatefulWidget {
  final provider;

  const PlayerStyleDialogWidget({Key? key, this.provider}) : super(key: key);

  @override
  State<PlayerStyleDialogWidget> createState() => _AlertDialogWidgetState();
}

class _AlertDialogWidgetState extends State<PlayerStyleDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppStrings.strPlayingStyle,
        textAlign: TextAlign.center,
        style: AppFonts.mazzardFont(TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColorBlue,
          fontSize: AppFontSize.font18,
        )),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: widget.provider.playingStyleList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                setState(() {});
              },
              titleAlignment: widget.provider.ratingListIndex == index
                  ? ListTileTitleAlignment.top
                  : ListTileTitleAlignment.center,
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                widget.provider.playingStyleTitlesList[index],
                style: AppFonts.poppinsFont(TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryColorBlack,
                  fontSize: AppFontSize.font14,
                )),
              ),
              leading: Container(
                height: AppFontSize.font28,
                width: AppFontSize.font45,
                decoration: BoxDecoration(
                  color: widget.provider.ratingListIndex == index
                      ? AppColors.primaryColorBlue
                      : AppColors.primaryColorSkyBlue,
                  borderRadius: BorderRadius.circular(AppFontSize.font12),
                ),
                child: Center(
                  child: Text(
                    widget.provider.playingStyleList[index].toString(),
                    style: AppFonts.poppinsFont(
                      TextStyle(
                        fontWeight: FontWeight.w600,
                        color: widget.provider.ratingListIndex == index
                            ? AppColors.secondaryColorWhite
                            : AppColors.primaryColorBlue,
                        fontSize: AppFontSize.font12,
                      ),
                    ),
                  ),
                ),
              ),
              trailing: InkWell(
                onTap: () {
                  widget.provider.getRatingIndex(index);
                  setState(() {});
                },
                child: widget.provider.ratingListIndex == index
                    ? Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: AppColors.secondaryColorBlack,
                      )
                    : Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: AppColors.secondaryColorBlack,
                      ),
              ),
              subtitle: widget.provider.ratingListIndex == index
                  ? Text(
                      widget.provider.playingStyleDescriptionList[index],
                      style: AppFonts.poppinsFont(
                        TextStyle(
                          fontSize: AppFontSize.font14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.secondaryColorBlack,
                        ),
                      ),
                    )
                  : null,
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
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
              fontSize: AppFontSize.font14,
              fontWeight: FontWeight.w600,
              color: AppColors.secondaryColorWhite,
            )),
            AppColors.primaryColorBlue,
          ),
        ),
      ],
    );
  }
}
