import 'package:flutter/material.dart';
import 'package:flutter_message_app_ui/views/cart.dart';
import 'package:flutter_message_app_ui/views/profile_screen.dart';
import 'views/sign_in.dart';
import 'views/sign_up.dart';
import 'views/product_listing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInPage(title: 'Mobily'),
      routes: {
        '/sign_up': (context) => const SignUpPage(
              title: 'OW2 Message App',
            ),
        '/product_listing': (context) => const ProductListingPage(),
        '/profile': (context) => const ProfileScreen(),
        '/sign_in': (context) => const SignInPage(
              title: 'OW2 Message App',
            ),
        '/cart': (context) => const CartPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
