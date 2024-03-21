import 'package:flutter/material.dart';
import 'package:llm_noticeboard/Api/messages.dart';

class Message_Model {
  Message_Model({required this.message});

  final String message;

  factory Message_Model.fromJson(Map<String, dynamic> json) {
    return Message_Model(
      message: json["message"] ?? "",
    );
  }
}
