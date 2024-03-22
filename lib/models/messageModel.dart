import 'package:flutter/material.dart';
import 'package:llm_noticeboard/Api/messages.dart';

class Message_Model {
  final String message;

  Message_Model({required this.message});

  factory Message_Model.fromJson(Map<String, dynamic> json) {
    return Message_Model(
      message: json["message"] ?? "", // Assuming "message" is the key for the message field
    );
  }
}
