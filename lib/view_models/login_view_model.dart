import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginViewModel {
  Future<Map<String, dynamic>> login(Map<String, String> parameter) async {
    try {
      final response = await http.post(
          Uri.parse("https://cda.namisite.in/api/login"),
          body: json.encode(parameter),
          headers: {
            'Content-Type': 'application/json',
          }).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        throw Exception(
          'Failed to login: ${response.statusCode} ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
