import 'package:cane_survey/screens/dashboard_screen.dart';
import 'package:cane_survey/shared_pref_helper.dart';
import 'package:cane_survey/view_models/submitViewModel.dart';
import 'package:flutter/material.dart';

class SurveyDataScreen extends StatefulWidget {
  final Map<String, dynamic> surveyData;

  SurveyDataScreen({required this.surveyData});

  @override
  _SurveyDataScreenState createState() => _SurveyDataScreenState();
}

class _SurveyDataScreenState extends State<SurveyDataScreen> {
  late Map<String, dynamic> surveyData;

  final Submitviewmodel _submitviewmodel = Submitviewmodel();

  String? token;

  @override
  void initState() {
    super.initState();
    // Initialize surveyData from widget property
    _initializeData();

    surveyData = widget.surveyData;
  }

  Future<void> _initializeData() async {
    await _loadToken();
  }

  Future<void> _loadToken() async {
    final authtoken = await SharedPrefHelper.getToken();

    setState(() {
      token = authtoken ?? "";
    });
  }

  bool _isLoading = false;

  void _submitSurvey() async {
    setState(() {
      _isLoading = true; // Show the progress indicator
    });

    // Simulate submission delay
    await Future.delayed(const Duration(seconds: 2));

    bool isSuccess =
        await _submitviewmodel.submitSurveyData(widget.surveyData, token!);

    setState(() {
      _isLoading = false; // Hide the progress indicator
    });

    // Show a dialog based on the submission response
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isSuccess ? 'Success' : 'Error'),
          content: Text(
            isSuccess
                ? 'Survey Submitted Successfully!'
                : 'Failed to submit survey. Please try again.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                if (isSuccess) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DashboardScreen())); // Navigate to the dashboard
                }
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Survey Data Review"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please review your survey data below before submission.',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: surveyData.entries.map((entry) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      title: Text(
                        entry.key,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      subtitle: Text(
                        entry.value.toString(),
                        style: const TextStyle(fontSize: 14.0),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitSurvey,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 40.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Submit Survey',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
