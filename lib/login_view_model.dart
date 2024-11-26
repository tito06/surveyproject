import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginViewModel {
  Future<void> login(Map<String, String> parameter) async {
    final response = await http.post(
        Uri.parse("https://canedev.birla-sugar.com/api/login"),
        body: json.encode(parameter),
        headers: {
          'Content-Type': 'application/json',
        }).timeout(Duration(seconds: 30));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print("Token :  ${data["token"]}");
    }
  }
}
