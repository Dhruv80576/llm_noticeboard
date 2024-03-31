import 'dart:convert';

import 'package:http/http.dart';
import 'package:llm_noticeboard/models/messageModel.dart';

class Message {
 Future<List<Message_Model>?> getMessages() async {
     
    List<Message_Model> messages = [];
    print('in the get messages function');
    try {
      Response response = await get(Uri.parse('https://link-to-backend.azurewebsites.net/messages'));
      print(response.body);
      List<dynamic> messageList = jsonDecode(response.body);
      for (var messageData in messageList) {
        messages.add(Message_Model(
          message: messageData['message'], 
         ));
      }
      print(messages[0].message);
      return messages;
    } catch (e) {
      print('failed');
      return null;
    }
  
  }
  

  Future<int> postMessage(String message) async {
          print('in the post message function');

    try {
        var body = {
         
    'message' : message
      };
 
    // Encode the request body
    String requestBody = jsonEncode(body);
      print(requestBody);
 
       Response response = await post(Uri.parse('https://link-to-backend.azurewebsites.net/post_message'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body:  requestBody);
      return response.statusCode;
    } catch (e) {
      print('failed');
    }
    return 0;
  }
}
