import 'dart:convert';
import 'package:http/http.dart' as http;

class Submitviewmodel {
  Future<bool> submitSurveyData(
      Map<String, dynamic> surveyData, String token) async {
    try {
      final response = await http.post(
        Uri.parse("https://cda.namisite.in/api/addCanesurvey"),
        body: json.encode(surveyData),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ).timeout(Duration(seconds: 30));

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        if (responseBody['success'] == true) {
          print('Data added successfully: ${responseBody['message']}');
          return true;
        } else {
          print('Error: ${responseBody['message']}');
          return false;
        }
      } else {
        print(
            'Failed to submit data. HTTP status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('An error occurred: $e');
      return false;
    }
  }
}
