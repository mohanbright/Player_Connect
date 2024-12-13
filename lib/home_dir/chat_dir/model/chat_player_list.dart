class ChatPlayerListing {
  int? id;
  int? senderId;
  int? receiverId;
  int? status;
  String? lastMessage;
  String? createdAt;
  String? updatedAt;
  String? senderFirstName;
  String? receiverFirstName;
  String? senderImages;
  String? receiverImages;
  String? senderCity;
  String? receiverCity;
  int? senderIsOnline;
  int? receiverIsOnline;

  ChatPlayerListing(
      {this.id,
      this.senderId,
      this.receiverId,
      this.status,
      this.lastMessage,
      this.createdAt,
      this.updatedAt,
      this.senderFirstName,
      this.receiverFirstName,
      this.senderImages,
      this.receiverImages,
      this.senderCity,
      this.receiverCity,
      this.senderIsOnline,
      this.receiverIsOnline});

  ChatPlayerListing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    status = json['status'];
    lastMessage = json['last_message'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    senderFirstName = json['sender_first_name'];
    receiverFirstName = json['receiver_first_name'];
    senderImages = json['sender_images'];
    receiverImages = json['receiver_images'];
    senderCity = json['sender_city'];
    receiverCity = json['receiver_city'];
    senderIsOnline = json['sender_is_online'];
    receiverIsOnline = json['receiver_is_online'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['status'] = status;
    data['last_message'] = lastMessage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['sender_first_name'] = senderFirstName;
    data['receiver_first_name'] = receiverFirstName;
    data['sender_images'] = senderImages;
    data['receiver_images'] = receiverImages;
    data['sender_city'] = senderCity;
    data['receiver_city'] = receiverCity;
    data['sender_is_online'] = senderIsOnline;
    data['receiver_is_online'] = receiverIsOnline;
    return data;
  }
}
