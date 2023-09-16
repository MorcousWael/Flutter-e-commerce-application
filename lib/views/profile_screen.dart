// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  final String profileImages =
      "https://images.unsplash.com/photo-1541562232579-512a21360020?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1887&q=80";

  const ProfileScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove('username');

    prefs.remove('cartItems');

    Navigator.pushNamedAndRemoveUntil(context, '/sign_in', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              _logout(context);
            },
            icon: const Icon(Icons.logout), // Add a logout button
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: SharedPreferences.getInstance()
              .then((prefs) => prefs.getString('username') ?? ''),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final userName = snapshot.data ?? 'User';
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(profileImages), // example profile image
                    radius: 50,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Hello, $userName!', // Display the user's name
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
