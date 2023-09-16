// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<String> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartItems();
  }

  // Function to load cart items from SharedPreferences
  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final savedItems = prefs.getStringList('cartItems') ?? [];
    setState(() {
      cartItems = savedItems;
    });
  }

  // Function to clear cart items in SharedPreferences
  Future<void> _clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('cartItems');
    setState(() {
      cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _clearCart(); // Clear cart items when the button is pressed
            },
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty.'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item),
                );
              },
            ),
    );
  }
}
