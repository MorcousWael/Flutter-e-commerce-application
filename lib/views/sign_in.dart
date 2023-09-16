// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String password = '';
  String username = ''; // Added username
  bool showPassword = false;

  void _validator(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter Username and Password'),
        ),
      );
    } else if (password.length < 8 || password.length > 16) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Password must be at least 8 characters and at most 16'),
        ),
      );
    } else {
      // Save username to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);

      // Navigate to the product_listing page after sign-in
      Navigator.pushReplacementNamed(context, '/product_listing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {
              // Navigate to the profile screen when the button is pressed
              Navigator.pushNamed(context, '/profile');
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1567581935884-3349723552ca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80",
                ),
                radius: 50,
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              onChanged: (value) {
                username = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
              ),
              obscureText: !showPassword,
              onChanged: (value) {
                password = value;
              },
            ),
            ElevatedButton(
              onPressed: () {
                _validator(username, password);
              },
              child: const Text('Sign in'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
