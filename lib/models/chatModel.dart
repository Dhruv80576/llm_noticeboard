class ChatMessageModel {
  final String? message;

  const ChatMessageModel({
    this.message,
  });

  factory ChatMessageModel.fromMap(Map data) {
    return ChatMessageModel(
      message: data['message'],
    );
  }
}
