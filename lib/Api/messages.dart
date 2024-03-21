import 'dart:convert';

import 'package:http/http.dart';
import 'package:llm_noticeboard/models/messageModel.dart';

class Message {
  Future<List<Message_Model>?> getMessages() async {
    List<Message_Model> messages = [];
    try {
      Response response = await get(Uri.parse(''));
      Map body_data = jsonDecode(response.body);
      List message = body_data[''];
      for (var element in message) {
        messages.add(element);
      }
      print(messages.elementAt(0).message);
      return messages;
    } catch (e) {
      print('failed');
    }
  }

  Future<int> postMessage(String body) async {
    try {
      Response response = await post(Uri.parse(''), body: {
        'message': body,
      });
      return response.statusCode;
    } catch (e) {
      print('failed');
    }
    return 0;
  }
}
