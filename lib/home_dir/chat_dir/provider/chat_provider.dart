import 'package:flutter/material.dart';
import 'package:player_connect/main.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:http/http.dart' as http;

class ChatProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  String? userName;
  String? userAddress;
  String? userImg;
  String messageId = "0";

  int _unreadMessages = 0;

  int get unreadMessages => _unreadMessages;

  void setUnreadMessages(int count) {
    _unreadMessages = count;
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

  Future getPlayerConnectList() async {
    var response = await http.get(
      Uri.parse("http://18.220.106.62:3000/connectedplayerlist"),
      headers: {
        'Authorization': 'Bearer ${UserDetails.userAuthToken!}',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  void removeChatMessage() {
    chatMessagesNotificationList.removeWhere((message) {
      return message.receiverID.toString() == UserDetails.userID &&
          message.senderID.toString() != UserDetails.userID;
    });
  }
}
