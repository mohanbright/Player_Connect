class NotificationChatMessageModel {
  String chatId;
  String senderID;
  String receiverID;
  String firstName;
  String lastName;
  String image;
  String city;
  String message;

  NotificationChatMessageModel({
    required this.chatId,
    required this.senderID,
    required this.receiverID,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.city,
    required this.message,
  });
}
