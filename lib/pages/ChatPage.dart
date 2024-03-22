import 'dart:async';
import 'package:flutter/material.dart';
import 'package:llm_noticeboard/Api/messages.dart';
import 'package:llm_noticeboard/models/chatModel.dart';
import 'package:llm_noticeboard/models/messageModel.dart';

class ChatPage extends StatefulWidget {
  final String groupId;

  ChatPage(this.groupId);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessageModel> _allMessagesContainedInTheStream = [];
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupId),
      ),
      body: ListView.builder(
        itemCount: _allMessagesContainedInTheStream.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 44,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.grey.shade400,
                ),
                child: Text(
                  _allMessagesContainedInTheStream[index].message!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomSheet: Container(
        padding: EdgeInsets.all(10),
        height: 70,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: "Type a message",
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                if (_messageController.text.trim().isNotEmpty) {
                  int statusCode = await Message().postMessage(_messageController.text);
                  setState(() {
                    _allMessagesContainedInTheStream.add(ChatMessageModel(message: _messageController.text));
                  });
                  _messageController.clear();
                }
              },
              icon: Icon(Icons.send),
            ),
          ],
        ),
      ),
    );
  }

  void getData() async {
    List<Message_Model>? temp = await Message().getMessages();
    if (temp != null) {
      setState(() {
        _allMessagesContainedInTheStream.addAll(temp.map((message) => ChatMessageModel(message: message.message)));
      });
    }
  }
}
