import 'package:cane_survey/dashboard_screen.dart';
import 'package:cane_survey/login_view_model.dart';
import 'package:cane_survey/new_survey.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel _loginViewModel = LoginViewModel();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _millIdController = TextEditingController();

  void _submit() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String millId = _millIdController.text.trim();

    if (username.isNotEmpty || password.isNotEmpty || millId.isNotEmpty) {
      Map<String, String> requestBody = {
        "email": username,
        "password": password,
        "user_ft_code": millId
      };

      try {
        final log = await _loginViewModel.login(requestBody);
      } catch (e) {
        print("excepton : $e");
      }
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                DashboardScreen() // Passing data to the next screen
            ),
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Please fill all fields')),
      // );
      // return;
    }

    // Handle login logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login successful for $username')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade700, Colors.green.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.agriculture,
                  size: 100,
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  "Cane Survey App",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _millIdController,
                  decoration: InputDecoration(
                    labelText: 'Mill ID',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade900,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _millIdController.dispose();
    super.dispose();
  }
}
