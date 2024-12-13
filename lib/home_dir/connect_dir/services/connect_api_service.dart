// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/home_dir/connect_dir/model/connectedPlayerModel.dart';
import 'package:player_connect/home_dir/connect_dir/model/requestModel.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/user_info.dart';

class ConnectPlayerApiService {
  static ConnectPlayerApiService? _instance;

  ConnectPlayerApiService._internal();

  static ConnectPlayerApiService getInstance() {
    _instance ??= ConnectPlayerApiService._internal();
    return _instance!;
  }

/* ==============================================Connect Player Api================================================*/
  List<SenderDetails> getReqPlayerList = [];
  List<ConnectedPlayerModelBody> getConnectPlayerList = [];

  Future<List<SenderDetails>> connectReqPlayer() async {
    try {
      var response = await http.get(
        Uri.parse(AppApiUtils.connectReqRequest),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          'Content-Type': 'application/json',
        },
      );
      print("connectReqPlayer::${response.statusCode}");
      // print("connectReqPlayer::${response.body}");
      if (response.statusCode == 200) {
        getReqPlayerList.clear();
        final jsonResponse = jsonDecode(response.body);
        // ConnectionReqModel playersListModel = ConnectionReqModel.fromJson(jsonResponse);
        // List<ConnectionReqModelBody> list = playersListModel.body!;
        // getReqPlayerList.addAll(list);

        ConnectionReqModel connectedReqModel =
            ConnectionReqModel.fromJson(jsonResponse);
        List<ConnectionReqModelBody> lists = connectedReqModel.body!;
        // print(lists[0].receiverId);
        List<SenderDetails> detailsList = [];
        for (int i = 0; i < lists.length; i++) {
          detailsList.add(lists[i].sender1!);
        }
        getReqPlayerList.addAll(detailsList);
        return getReqPlayerList;
      } else {
        return [];
        // AppSnackBarToast.buildShowSnackBar(
        //     context, AppStrings.strSomethingWrong);
      }
    } catch (e) {
      print(e);
      // AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return [];
    }
  }

  Future<List<ConnectedPlayerModelBody>> connectPlayer() async {
    try {
      var response = await http.get(
        Uri.parse(AppApiUtils.connectedPlayerRequest),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          'Content-Type': 'application/json',
        },
      );
      print("connectPlayer statusCode::: ${response.statusCode}");
      // print("connectPlayer body::: ${response.body}");
      if (response.statusCode == 200) {
        getConnectPlayerList.clear();
        final jsonResponse = jsonDecode(response.body);
        // ConnectionReqModel playersListModel =
        // ConnectionReqModel.fromJson(jsonResponse);
        // getConnectPlayerList.addAll(list);

        ConnectedPlayerModel connectedReqModel =
            ConnectedPlayerModel.fromJson(jsonResponse);
        List<ConnectedPlayerModelBody> list = connectedReqModel.body!;
        getConnectPlayerList.addAll(list);

        return getConnectPlayerList;
      } else {
        print("object");
        // AppSnackBarToast.buildShowSnackBar(
        //     context, AppStrings.strSomethingWrong);
        return [];
      }
    } catch (e) {
      print(e);
      // AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return [];
    }
  }
}
