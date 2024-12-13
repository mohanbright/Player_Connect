// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:player_connect/home_dir/chat_dir/model/chatModel.dart';
import 'package:player_connect/home_dir/chat_dir/model/chat_player_list.dart';
import 'package:player_connect/home_dir/chat_dir/provider/chat_provider.dart';
import 'package:player_connect/home_dir/connect_dir/model/connectedPlayerModel.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/main.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/provider/routes_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../shared/auth/routes.dart';

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, prefer_final_fields

import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:player_connect/home_dir/chat_dir/model/chatModel.dart';
import 'package:player_connect/home_dir/chat_dir/model/chat_player_list.dart';
import 'package:player_connect/home_dir/chat_dir/provider/chat_provider.dart';
import 'package:player_connect/home_dir/connect_dir/model/connectedPlayerModel.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/main.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/provider/routes_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';

import '../../../shared/auth/routes.dart';

class ChatDetailsPage extends StatefulWidget {
  final ChatPlayerListing? name;

  const ChatDetailsPage({Key? key, required this.name}) : super(key: key);

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  TextEditingController msgController = TextEditingController();
  IO.Socket? socket;
  List<ChatMessage> chatMessages = [];
  List chatdetail = [];
  int unreadMessageCount = 0;
  bool isLoading = false;

  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    socket?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    chatdetail.clear();
    Provider.of<RoutesProvider>(context, listen: false)
        .getCurrentClassName(context);

    isLoading = true;
    setState(() {});
    socket = IO.io("http://18.220.106.62:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket?.connect();
    Map<String, dynamic> jsonData = {
      'sender_id': widget.name!.senderId,
      'reciever_id': widget.name!.receiverId,
    };
    socket?.emit('get_chat_history', jsonData);

    socket?.on('get_chat_history', (data) {
      setState(() {
        chatdetail.addAll(data);
      });
      for (int i = 0; i < chatdetail.length; i++) {
        setState(() {
          chatMessages.add(ChatMessage(
            sender: chatdetail[i]['sender_id'].toString(),
            receiver: chatdetail[i]['reciever_id'].toString(),
            message: chatdetail[i]['message'],
            timestamp: DateTime.parse(chatdetail[i]['created_at']),
          ));
        });
      }
      updateUnreadCount();
      if (chatMessages.isNotEmpty) {
        Timer(Duration(milliseconds: 300), () {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
      setState(() {
        isLoading = false;
      });
    });

    socket?.on('chat_message', (data) {
      if (UserDetails.userID.toString() == data['sender_id'].toString() ||
          UserDetails.userID.toString() == data['reciever_id'].toString()) {
        setState(() {
          chatMessages.add(ChatMessage(
            sender: data['sender_id'].toString(),
            receiver: data['reciever_id'].toString(),
            message: data['message'].toString(),
            timestamp: DateTime.now(),
          ));
          updateUnreadCount();
          Timer(Duration(milliseconds: 300), () {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          });
        });
      }
    });
  }

  void updateUnreadCount() {
    unreadMessageCount = chatMessages
        .where(
            (msg) => msg.receiver == UserDetails.userID.toString() && !msg.read)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Consumer<ChatProvider>(builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: AppColors.bgColor,
            iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
            title: ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Provider.of<PlayerProvider>(context, listen: false)
                          .getIndividualProfileData(
                              context, widget.name?.receiverId);
                      Navigator.pushNamed(context, AppRoutes.playerProfilePage);
                    },
                    child: Text(
                      widget.name!.receiverFirstName.toString(),
                      style: AppFonts.poppinsFont(
                        TextStyle(
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColorBlue,
                          fontSize: AppFontSize.font12,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<PlayerProvider>(context, listen: false)
                          .getIndividualProfileData(
                              context, widget.name?.receiverId);
                      Navigator.pushNamed(context, AppRoutes.playerProfilePage);
                    },
                    child: Text(
                      AppStrings.strViewProfile,
                      style: AppFonts.mazzardFont(TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColorBlue,
                        fontSize: AppFontSize.font10,
                      )),
                    ),
                  ),
                ],
              ),
              subtitle: Text(
                widget.name!.receiverCity.toString(),
                maxLines: 1,
                style: AppFonts.mazzardFont(TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryColorBlack,
                  fontSize: AppFontSize.font10,
                )),
              ),
              leading: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Provider.of<PlayerProvider>(context, listen: false)
                          .getIndividualProfileData(
                              context, widget.name?.receiverId);
                      Navigator.pushNamed(context, AppRoutes.playerProfilePage);
                    },
                    child: CircleAvatar(
                      radius: AppFontSize.font20,
                      backgroundImage: NetworkImage(
                        "http://18.220.106.62:3000/images/${widget.name!.receiverImages}",
                      ),
                    ),
                  ),
                  if (widget.name!.receiverIsOnline == 1)
                    Positioned(
                      right: -1,
                      bottom: -1,
                      child: Container(
                        height: AppFontSize.font12,
                        width: AppFontSize.font12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius:
                              BorderRadius.circular(AppFontSize.font8),
                          border: Border.all(
                            color: AppColors.secondaryColorWhite,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: AppFontSize.font12),
                  isLoading
                      ? Container(
                          height: MediaQuery.of(context).size.height / 10,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : chatMessages.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: chatMessages.length,
                                dragStartBehavior: DragStartBehavior.down,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final message = chatMessages[index];
                                  if (UserDetails.userID ==
                                          chatMessages[index].receiver &&
                                      !chatMessages[index].read) {
                                    Map<String, dynamic> jsonDataRead = {
                                      'messageId': int.parse(
                                        provider.messageId,
                                      ),
                                    };
                                    socket?.emit('readUnread', jsonDataRead);
                                    socket?.on('readUnread', (data) {});
                                  }

                                  return Row(
                                    mainAxisAlignment: message.sender !=
                                            UserDetails.userID.toString()
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ChatMessageWidget(
                                          index: index,
                                          message: message,
                                          img: widget.name!.receiverImages!,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height / 10,
                              child: Center(
                                child: Text("No Message"),
                              ),
                            ),
                  SizedBox(height: AppFontSize.font60),
                ],
              ),
              Column(
                children: [
                  Spacer(),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppFontSize.font8,
                        1,
                        AppFontSize.font8,
                        AppFontSize.font8,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColorLightGrey,
                          borderRadius: BorderRadius.circular(
                            AppFontSize.font12,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: AppFontSize.font12,
                            vertical: AppFontSize.font12),
                        child: Row(
                          children: [
                            SizedBox(width: AppFontSize.font10),
                            Expanded(
                              child: TextFormField(
                                controller: msgController,
                                decoration: InputDecoration(
                                  hintText: AppStrings.strWriteMessage,
                                  hintStyle: AppFonts.poppinsFont(
                                    TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryColorBlack
                                          .withOpacity(0.5),
                                      fontSize: AppFontSize.font14,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            SizedBox(width: AppFontSize.font10),
                            InkWell(
                              onTap: () async {
                                if (msgController.text.trim().isNotEmpty) {
                                  setState(() {
                                    Map<String, dynamic> jsonData = {
                                      'sender_id':
                                          widget.name!.senderId.toString() ==
                                                  UserDetails.userID.toString()
                                              ? UserDetails.userID
                                              : widget.name!.receiverId,
                                      'reciever_id':
                                          widget.name!.senderId.toString() ==
                                                  UserDetails.userID.toString()
                                              ? widget.name!.receiverId
                                              : widget.name!.senderId,
                                      'message': msgController.text
                                          .trimLeft()
                                          .trimRight(),
                                      'status': 0,
                                    };
                                    socket?.emit('chat_message', jsonData);
                                    Timer(
                                      Duration(milliseconds: 300),
                                      () {
                                        _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration: Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.easeOut,
                                        );
                                        setState(() {});
                                      },
                                    );
                                    msgController.clear();
                                  });
                                }
                              },
                              child: Image(
                                image: AssetImage(AppIconImages.sendMsgIconImg),
                                height: AppFontSize.font18,
                                width: AppFontSize.font22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ChatMessage {
  final String sender;
  final String receiver;
  final String message;
  final DateTime timestamp;
  bool read;

  ChatMessage({
    required this.sender,
    required this.receiver,
    required this.message,
    required this.timestamp,
    this.read = false,
  });
}

class ChatMessageWidget extends StatefulWidget {
  final int index;
  final String img;
  final ChatMessage message;

  const ChatMessageWidget({
    super.key,
    required this.message,
    required this.index,
    required this.img,
  });

  @override
  State<ChatMessageWidget> createState() => _ChatMessageWidgetState();
}

class _ChatMessageWidgetState extends State<ChatMessageWidget> {
  // Duration duration = Duration(seconds: 50); // 50 seconds interval

  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 9), (Timer timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final getTime = formatTimestamp(widget.message.timestamp);
    return widget.message.sender != UserDetails.userID.toString()
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                  radius: AppFontSize.font8,
                  backgroundColor: AppColors.primaryColorSkyBlue,
                  backgroundImage:
                      NetworkImage(AppApiUtils.imageUrl + widget.img)),
              SizedBox(width: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width *
                          0.7, // Adjust as needed
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.infoPageCount.withOpacity(0.4),
                        borderRadius:
                            BorderRadius.circular(AppFontSize.font16)),
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(widget.message.message,
                          style: AppFonts.poppinsFont(TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryColorBlack,
                              fontSize: AppFontSize.font16))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                    child: Text(getTime,
                        style: AppFonts.mazzardFont(TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.infoPageCount,
                            fontSize: AppFontSize.font10))),
                  ),
                ],
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                        color: AppColors.primaryColorBlue,
                        borderRadius:
                            BorderRadius.circular(AppFontSize.font16)),
                    child: Padding(
                      padding: EdgeInsets.all(14),
                      child: Text(widget.message.message,
                          style: AppFonts.poppinsFont(TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryColorWhite,
                              fontSize: AppFontSize.font16))),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 14, 0),
                    child: Row(
                      children: [
                        Text(getTime,
                            style: AppFonts.mazzardFont(TextStyle(
                                fontWeight: FontWeight.w500,
                                color: AppColors.infoPageCount,
                                fontSize: AppFontSize.font10))),
                        SizedBox(width: AppFontSize.font6),
                        Image(
                          image: AssetImage(AppIconImages.msgSentIconImg),
                          width: AppFontSize.font10,
                          height: AppFontSize.font8,
                          color: AppColors.infoPageCount,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(width: 4),
              CircleAvatar(
                radius: AppFontSize.font8,
                backgroundImage: NetworkImage(UserDetails.userPhoto.toString()),
                // backgroundColor: AppColors.primaryColorSkyBlue,
              )
            ],
          );
  }

  String formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    // You can customize the format as needed
    final format = DateFormat('hh:mm a');

    if (difference.inDays >= 2) {
      final formattedDate =
          '${timestamp.day.toString().padLeft(2, '0')} ${DateFormat.MMM().format(timestamp)} at ${DateFormat('hh:mm a').format(timestamp)}';
      return formattedDate;
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${format.format(timestamp)}';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours == 1) {
      return '1 hour ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} mins ago';
    } else {
      return 'Just now';
    }
  }
}
