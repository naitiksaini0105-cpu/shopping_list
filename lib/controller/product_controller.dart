import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_demo/model/product_model.dart';
import 'package:shopping_demo/services/api_service.dart';

class ProductController extends GetxController {
  final ApiService apiService = ApiService();

  final TextEditingController searchController = TextEditingController();

  var isLoading = true.obs;

  var products = <Product>[].obs;

  var errorMessage = ''.obs;

  var categories = <String>[].obs;

  var selectedCategory = "All Products".obs;

  var selectedSort = "Default".obs;

  @override
  void onInit() {
    fetchProducts();
    fetchCategories();
    super.onInit();
  }

  void clearSearch() {
    searchController.clear();

    fetchProducts();
  }

  void toggleFavorite(int id) {
    final index = products.indexWhere((p) => p.id == id);

    if (index != -1) {
      products[index].isFavorite = !products[index].isFavorite;
      products.refresh();
    }
  }

  void updateLocalProduct(Product updatedProduct) {
    final index = products.indexWhere((p) => p.id == updatedProduct.id);

    if (index != -1) {
      products[index] = updatedProduct;
      products.refresh();
    }
  }

  List<Product> get favoriteProducts =>
      products.where((p) => p.isFavorite).toList();

  void sortProducts(String value) {
    selectedSort.value = value;

    switch (value) {
      case "Price (Low to High)":
        products.sort((a, b) => a.price.compareTo(b.price));
        break;

      case "Price (High to Low)":
        products.sort((a, b) => b.price.compareTo(a.price));
        break;

      case "Rating":
        products.sort((a, b) => b.rating.compareTo(a.rating));
        break;

      case "Name (A-Z)":
        products.sort((a, b) => a.title.compareTo(b.title));
        break;

      default:
        fetchProducts();
        return;
    }

    products.refresh();
  }

  Future<void> fetchProducts() async {
    try {
      print("Fetching products...");

      isLoading(true);

      errorMessage('');

      final result = await apiService.fetchProducts();
      print("Products received: ${result.length}");
      products.assignAll(result);
      print(products.length);
      print(products.first.title);
    } catch (e) {
      print("ERROR: $e");
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> searchProduct(String keyword) async {
    if (keyword.trim().isEmpty) {
      fetchProducts();

      return;
    }

    try {
      isLoading(true);

      errorMessage('');

      final result = await apiService.searchProducts(keyword);

      products.assignAll(result);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      final success = await apiService.deleteProduct(id);

      if (success) {
        products.removeWhere((product) => product.id == id);

        Get.snackbar("Success", "Product Deleted Successfully");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> fetchCategories() async {
    try {
      final result = await apiService.fetchCategories();

      categories.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> filterCategory(String category) async {
    selectedCategory.value = category;

    if (category == "All Products") {
      fetchProducts();
      return;
    }

    isLoading(true);

    try {
      final result = await apiService.getProductsByCategory(category);

      products.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
