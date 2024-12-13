import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:player_connect/home_dir/connect_dir/provider/connect_provider.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:provider/provider.dart';

class RequestResponseApiService {
  static RequestResponseApiService? _instance;

  RequestResponseApiService._internal();

  static RequestResponseApiService getInstance() {
    _instance ??= RequestResponseApiService._internal();
    return _instance!;
  }

/* ==============================================Send Request Api================================================*/

  Future? sendRequest(context, id, index, type) async {
    try {
      var response = await http.post(
        Uri.parse(AppApiUtils.sendRequest),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          // 'Content-Type': 'application/json',
        },
        body: {
          "receiverId": id.toString(),
          "status": "1",
        },
      );
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        // AppSnackBarToast.buildShowSnackBar(context, jsonResponse["message"]);
        type == 1
            ? Provider.of<PlayerProvider>(context, listen: false)
                .getSearchPlayersList[index]
                .receiverStatus2 = 1
            : type == 2
                ? Provider.of<PlayerProvider>(context, listen: false)
                    .getPlayersList[index]
                    .senderStatus2 = 1.toString()
                : type == 3
                    ? Provider.of<PlayerProvider>(context, listen: false)
                        .getRecommendedPlayersList[index]
                        .senderStatus2 = 1
                    : Provider.of<PlayerProvider>(context, listen: false)
                        .getIndividualPlayersList[index]
                        .senderStatus1 = 1;

        // .receiverRequestStatus = 1;

        // final PlayersListModel user = PlayersListModel.fromJson(jsonResponse);
        // return user;
      } else {
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strSomethingWrong);
      }
    } catch (e) {
      print(e);
      AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return e;
    }
  }

  /* ==============================================Res Request Api================================================*/

  Future? respRequest(context, int id, int status, index) async {
    print(id);
    try {
      final Map<String, dynamic> requestData = {
        // "receiverId": id,
        "senderId": id.toString(),
        "status": status.toString(),
      };
      var response = await http.post(
        Uri.parse(AppApiUtils.accRejRequest),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          'Content-Type': 'application/json',
        },
        body: json.encode(requestData),
        // body: requestData,
      );
      // print("respRequest::${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        // final PlayersListModel user = PlayersListModel.fromJson(jsonResponse);
        // return user;

        // AppSnackBarToast.buildShowSnackBar(
        //     context,
        //     status == 2
        //         ? "Friend request accepted successfully"
        //         : "Friend request deleted successfully");
        Provider.of<ConnectProvider>(context, listen: false)
            .getReqPlayerList
            .removeAt(index);
        status == 2
            ? Provider.of<ConnectProvider>(context, listen: false)
                .connectPlayer()
            : null;
      } else {
        // print(response.body);
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strSomethingWrong);
      }
    } catch (e) {
      print("respRequest::$e");
      AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return e;
    }
  }

  /* ==============================================Delete Request Api================================================*/

  Future? deleteRequest(context, index, type, id) async {
    try {
      var response = await http.delete(
        Uri.parse(AppApiUtils.deleteConnRequest),
        headers: {
          'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
          // 'Content-Type': 'application/json',
        },
        body: {
          "receiverId": id.toString(),
        }, // body: json.encode(requestData),
      );
      // print("deleteRequest.body::::${response.body}");

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        // final PlayersListModel user = PlayersListModel.fromJson(jsonResponse);
        // return user;
        // AppSnackBarToast.buildShowSnackBar(
        //     context, "Request delete successfully");

        if (type == 1) {
          var item = Provider.of<PlayerProvider>(context, listen: false)
              .getSearchPlayersList[index];
          item.receiverStatus1 = null;
          item.receiverStatus2 = null;
          item.senderStatus1 = null;
          item.senderStatus2 = null;
        } else if (type == 2) {
          var item = Provider.of<PlayerProvider>(context, listen: false)
              .getPlayersList[index];
          item.receiverStatus1 = null;
          item.receiverStatus2 = null;
          item.senderStatus1 = null;
          item.senderStatus2 = null;
        } else if (type == 3) {
          var item = Provider.of<PlayerProvider>(context, listen: false)
              .getRecommendedPlayersList[index];
          item.receiverStatus1 = null;
          item.receiverStatus2 = null;
          item.senderStatus1 = null;
          item.senderStatus2 = null;
        } else {
          var item = Provider.of<PlayerProvider>(context, listen: false)
              .getIndividualPlayersList[index];
          item.receiverStatus1 = null;
          item.receiverStatus2 = null;
          item.senderStatus1 = null;
          item.senderStatus2 = null;
        }
      } else {
        // print(response.body);
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strSomethingWrong);
      }
    } catch (e) {
      print(e);
      AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      return e;
    }
  }
}
