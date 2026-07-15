import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shopping_demo/model/product_model.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List products = data['products'];

      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Failed to Load Products");
    }
  }

  Future<Product> fetchProductDetail(int id) async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products/$id"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return Product.fromJson(data);
    } else {
      throw Exception("Failed to load product");
    }
  }

  Future<List<Product>> searchProducts(String keyword) async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products/search?q=$keyword"),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List products = data["products"];

      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception("Search Failed");
    }
  }

  Future<bool> deleteProduct(int id) async {
    final response = await http.delete(
      Uri.parse("https://dummyjson.com/products/$id"),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception("Failed to delete product");
    }
  }

  Future<Product> addProduct({
    required String title,
    required String description,
    required double price,
    required String category,
  }) async {
    final response = await http.post(
      Uri.parse("https://dummyjson.com/products/add"),

      headers: {"Content-Type": "application/json"},

      body: jsonEncode({
        "title": title,
        "description": description,
        "price": price,
        "category": category,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to add product");
    }
  }

  Future<List<String>> fetchCategories() async {
    final response = await http.get(
      Uri.parse("https://dummyjson.com/products/categories"),
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      return data.map((e) => e['name'].toString()).toList();
    } else {
      throw Exception("Failed to load categories");
    }
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final response = await http.get(Uri.parse("$baseUrl/category/$category"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data['products'] as List)
          .map((e) => Product.fromJson(e))
          .toList();
    } else {
      throw Exception("Failed to load category");
    }
  }
}
