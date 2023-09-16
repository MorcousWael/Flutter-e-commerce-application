// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_message_app_ui/model/product_model.dart';
import 'package:flutter_message_app_ui/services/product_services.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductListingPage extends StatefulWidget {
  const ProductListingPage({Key? key}) : super(key: key);

  @override
  _ProductListingPageState createState() => _ProductListingPageState();
}

class _ProductListingPageState extends State<ProductListingPage> {
  List<Product> products = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final productsList = await ProductServices().getHttp();
      setState(() {
        products = productsList;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Error fetching products: $error';
        isLoading = false;
      });
    }
  }

  // add a product to the cart and cache it using shared preferences
  Future<void> _addToCart(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartItems = prefs.getStringList('cartItems') ?? [];
    cartItems.add(product.title);
    prefs.setStringList('cartItems', cartItems);
    // snackbar to indicate product has been added to the cart
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product added to the cart'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
        title: const Text('Mobily'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(product.title),
                          subtitle:
                              Text('Price: \$${product.price.toString()}'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              _addToCart(product);
                            },
                            child: const Text('Add to Cart'),
                          ),
                        ),
                        CarouselSlider(
                          items: product.images.map((imageUrl) {
                            return Image.network(imageUrl);
                          }).toList(),
                          options: CarouselOptions(
                            height: 200,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 0.8,
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
    );
  }
}
