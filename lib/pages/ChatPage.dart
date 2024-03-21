import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:llm_noticeboard/Api/messages.dart';
import 'package:llm_noticeboard/models/chatModel.dart';
import 'package:llm_noticeboard/models/messageModel.dart';

var _groupId;
StreamController<ChatMessageModel> _chatMessagesStreamController =
    StreamController<ChatMessageModel>.broadcast();
Stream _chatMessagesStream = _chatMessagesStreamController.stream;

class ChatPage extends StatefulWidget {
  final groupId;
  ChatPage(this.groupId) {
    _groupId = groupId;
  }
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<ChatMessageModel> _allMessagesContainedInTheStream = [];
  TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    getData();
    _chatMessagesStream.listen((streamedMessages) {
      // _allMessagesContainedInTheStream.clear();

      debugPrint('Value from controller: $streamedMessages');

      _allMessagesContainedInTheStream.add(streamedMessages);
    });
    super.initState();
  }
  // final StreamController<ChatMessageModel> _chatMessagesStreamController =
  //     StreamController<ChatMessageModel>.broadcast();
  // final Stream<ChatMessageModel> _chatMessagesStream =
  //     _chatMessagesStreamController.stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_groupId),
      ),
      body: Container(
        // child: StreamBuilder<ChatMessageModel>(
        //   stream: _chatMessagesStream,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       return ListView.builder(
        //         itemCount: snapshot.data!.length,
        //         itemBuilder: (context, index) {
        //           return ListTile(
        //             title: Text(snapshot.data![index].message!),
        //           );
        //         },
        //       );
        //     } else {
        //       return Center(child: CircularProgressIndicator());
        //     }
        //   },
        // ),
        child: StreamBuilder(
          stream: _chatMessagesStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: _allMessagesContainedInTheStream.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.shade400,
                        ),
                        child: Flexible(
                          child: Text(
                            softWrap: true,
                            _allMessagesContainedInTheStream[index].message!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            } else {
              return Center(child: Text("No messages yet"));
            }
          },
        ),
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
                if (_messageController.text != '' ||
                    _messageController.text != ' ') {
                  int statusCode =
                      await Message().postMessage(_messageController.text);
                  _chatMessagesStreamController
                      .add(ChatMessageModel(message: _messageController.text));
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
    for (var element in temp!) {
      _chatMessagesStreamController
          .add(ChatMessageModel(message: element.message));
    }
  }
}
