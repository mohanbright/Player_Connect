import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/connect_dir/model/connectedPlayerModel.dart';
import 'package:player_connect/home_dir/connect_dir/model/requestModel.dart';
import 'package:player_connect/home_dir/connect_dir/services/connect_api_service.dart';
import 'package:player_connect/home_dir/player_dir/services/response_request_api_service.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';

class ConnectProvider extends ChangeNotifier {
  List<SenderDetails> getReqPlayerList = [];
  List<ConnectedPlayerModelBody> getConnectPlayerList = [];

  bool isLoading = false;
  bool isRequestLoading = false;
  bool isConnectedLoading = false;

  /* ==============================================Deny Request Api================================================*/

  Future? responseRequest(context, id, status, index) async {
    isLoading = true;
    notifyListeners();
    await RequestResponseApiService.getInstance()
        .respRequest(context, id, status, index);
    isLoading = false;
    notifyListeners();
    return;
  }

  Future? connectReqPlayer() async {
    // isLoading = true;
    // notifyListeners();
    isRequestLoading = true;
    getReqPlayerList.clear();
    getReqPlayerList = await ConnectPlayerApiService.getInstance()
        .connectReqPlayer()
        .whenComplete(() {
      notifyListeners();
    });
    isLoading = false;
    isRequestLoading = false;
    notifyListeners();
  }

  Future? connectPlayer() async {
    // isLoading = true;
    isConnectedLoading = true;
    // notifyListeners();
    getConnectPlayerList.clear();
    getConnectPlayerList = await ConnectPlayerApiService.getInstance()
        .connectPlayer()
        .whenComplete(() {
      notifyListeners();
    });
    isLoading = false;
    isConnectedLoading = false;
    notifyListeners();
  }

  Widget buildText(text) {
    return Text(text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppFonts.mazzardFont(TextStyle(
            fontSize: AppFontSize.font10,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryColorBlack)));
  }
}
