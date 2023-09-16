// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name = '';
  String username = '';
  String password = '';

  bool showPassword = false;

  void _validator(String name, String username, String password) async {
    if (name.isEmpty || username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter Name, Username, and Password'),
        ),
      );
    } else if (name.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Name must be at least 2 characters'),
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

      // Navigate to the product_listing page after sign-up
      Navigator.pushReplacementNamed(context, '/product_listing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://images.unsplash.com/photo-1567581935884-3349723552ca?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1974&q=80"),
                radius: 50,
              ),
            ),
            TextFormField(
              // Use TextFormField instead of TextField
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
              onChanged: (value) {
                name = value;
              },
            ),
            TextFormField(
              // Use TextFormField instead of TextField
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              onChanged: (value) {
                username = value;
              },
            ),
            TextFormField(
              // Use TextFormField instead of TextField
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
                _validator(name, username, password);
              },
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}
