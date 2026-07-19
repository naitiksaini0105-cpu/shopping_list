import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_demo/model/product_model.dart';
import 'package:shopping_demo/services/api_service.dart';
import 'package:shopping_demo/controller/product_controller.dart';

class EditProductController extends GetxController {
  final ApiService apiService = ApiService();
  final ProductController productController = Get.find<ProductController>();

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final brandController = TextEditingController();
  final ratingController = TextEditingController();
  final stockController = TextEditingController();
  final imageController = TextEditingController();

  var selectedCategory = ''.obs;

  var isLoading = false.obs;

  late Product product;

  void loadProduct(Product productData) {
    product = productData;

    titleController.text = product.title;
    descriptionController.text = product.description;
    priceController.text = product.price.toString();
    brandController.text = product.brand.toString();
    ratingController.text = product.rating.toString();
    stockController.text = product.stock.toString();
    imageController.text = product.thumbnail;
    selectedCategory.value = product.category;
  }

  Future<void> updateProduct() async {
    print("Update button pressed");

    if (!formKey.currentState!.validate()) {
      print("Validation failed");
      return;
    }
    print("Step 3: Validation Passed");
    try {
      isLoading.value = true;
      print("Step 4: Before API");
      final updatedProduct = await apiService.updateProduct(
        id: product.id,
        title: titleController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text),
        category: selectedCategory.value,
        brand: brandController.text.trim().isEmpty
            ? null
            : brandController.text.trim(),
        thumbnail: imageController.text.trim().isEmpty
            ? null
            : imageController.text.trim(),
        rating: ratingController.text.trim().isEmpty
            ? null
            : double.parse(ratingController.text),
        stock: stockController.text.trim().isEmpty
            ? null
            : int.parse(stockController.text),
      );

      print("Step 5");
      print(updatedProduct);

      Get.snackbar(
        "Success",
        "Product updated successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
      productController.updateLocalProduct(updatedProduct);
      print("Returning Product:");
      print(updatedProduct.title);
      print(updatedProduct.price);
      print(updatedProduct);
      Get.back(result: updatedProduct);
    } catch (e) {
      // print("UPDATE ERROR: $e");

      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    brandController.dispose();
    ratingController.dispose();
    stockController.dispose();
    imageController.dispose();
    super.onClose();
  }
}
