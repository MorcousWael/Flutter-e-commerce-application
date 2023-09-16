import 'package:dio/dio.dart';
import 'package:flutter_message_app_ui/model/product_model.dart';

class ProductServices {
  final String _url = "https://dummyjson.com/products?limit=10";
  final dio = Dio();

  Future<List<Product>> getHttp() async {
    List<Product> products = [];

    try {
      final response = await dio.get(_url);
      if (response.statusCode == 200) {
        final data = response.data;
        data['products'].forEach((element) {
          products.add(Product.fromJson(element));
        });
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
