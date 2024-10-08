import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:motomaps/Pages/signup.dart';
import 'package:http/http.dart' as http;

import '../utils/HoverTextField.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _error;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> login() async {
    const String url = "https://motomaps-backend-1-gvet.onrender.com/auth/login";
    final email = _emailController.text.toString().trim();
    final password = _passwordController.text.toString().trim();

    if (email.isEmpty || password.isEmpty) {
      _error = "All fields are mandatory";
      return;
    }

    final Map<String, dynamic> formData = {
      'email': email,
      'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(formData),
        // credentials: 'include',
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Dispatch success action here (e.g., using a state management solution)
        print("Login successful: $data");
        // Navigate to home screen
      } else {
        final data = json.decode(response.body);
        // Handle error
        print("Error: ${data['error']}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // App Logo
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('lib/Assets/wheel-small.png'), // Update path as needed
                  backgroundColor: Colors.black, // Ensures background color is black
                ),
                const SizedBox(height: 20),
                // App Name
                Text(
                  'MotoMaps.',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Login Title
                Text(
                  'Log in',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Login Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      HoverTextField(
                        controller: _emailController,
                        labelText: 'Username',
                      ),
                      const SizedBox(height: 15),
                      HoverTextField(
                        controller: _passwordController,
                        labelText: 'Password',
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800], // Darker gray background
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    child: Text(
                        'Login',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  height: 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white.withOpacity(0),
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle Google sign-up here
                    },
                    icon: Image.asset(
                      'lib/Assets/google-logo.png',
                    ),
                    label: Text(
                      'Signup with Google',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[800], // Ensure this color matches the theme's button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white, // Ensure this uses the theme's text color
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // "Join if new user" Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'New rider? ',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.normal,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlueAccent,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SignUpPage()),
                              );
                            },
                        ),
                      ],
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
}