import 'dart:convert';
import 'package:http/http.dart' as http;

class Auth {
  Future<int?> login(int rollno, String password) async {
    try {
            print(rollno);
            print(password); 

      var body = {
         
        'rollno': rollno.toString(),
        'password': password,
      };
 
    // Encode the request body
    String requestBody = jsonEncode(body);
    print(requestBody);
 
      http.Response response = await http.post(
        Uri.parse('http://localhost:3090/login'),  
            headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
        body:  requestBody,
      );
      return response.statusCode;
    } catch (e) {
      print(e);
    }
    return 0;
  }

  Future<int?> signup(String name, int rollno, String password) async {
    try {
      print("in the signup function");
      print(name);
      print(rollno);
      print(password);  
      var body = {
        'username': name,
        'rollno': rollno,
        'password': password,
      };

    // Encode the request body
    String requestBody = jsonEncode(body);

    // Send the POST request
    var response = await http.post(
      Uri.parse('http://localhost:3090/create_user'),  
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBody,
    );
    print(response.statusCode);
      return response.statusCode;
    } catch (e) {
      print(e);
    }
    return 0;
  }
}

