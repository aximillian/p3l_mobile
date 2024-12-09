import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:p3l_mobile/entity/product%20.dart';

class ProductService {
  static const String baseUrl = 'http://atmabueatyapi.site/api';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/produk'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return (data as List).map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Product> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/produk/$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return Product.fromJson(data);
    } else {
      throw Exception('Product not found');
    }
  }

  Future<List<Product>> searchProductsByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/produk/search/$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      return (data as List).map((json) => Product.fromJson(json)).toList();
    } else {
      return [];
    }
  }
}
