import 'package:cane_survey/new_survey.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Can Survey Dashboard'),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bgm.png'), // Add your image here
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            InputFormScreen() // Passing data to the next screen
                        ),
                  );
                  print('Button Pressed');
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Button background color
                foregroundColor: Colors.green, // Button text color
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: Text('Start Survey'),
            ),
          ),
        ],
      ),
    );
  }
}
