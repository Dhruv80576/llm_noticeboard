import 'dart:convert';

import 'package:http/http.dart';

class Auth {
  Future<int?> login(int rollno, String password) async {
    try {
      Response response = await post(Uri.parse('/login'), body: {
        "rollno": rollno,
        "password": password,
      });
      return response.statusCode;
    } catch (e) {
      print(e);
    }
    return 0;
  }

  Future<int?> signup(String name, int rollno, String password) async {
    try {
      Response response = await post(Uri.parse('/signup'), body: {
        "name": name,
        "rollno": rollno,
        "password": password,
      });
      return response.statusCode;
    } catch (e) {
      print(e);
    }
    return 0;
  }
}
