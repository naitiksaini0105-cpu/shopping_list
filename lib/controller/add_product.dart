import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_demo/services/api_service.dart';
import 'package:shopping_demo/controller/product_controller.dart';

class AddProductController extends GetxController {
  final ApiService apiService = ApiService();

  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final priceController = TextEditingController();

  var selectedCategory = ''.obs;

  var isLoading = false.obs;

  Future<void> submitProduct() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading(true);

      final product = await apiService.addProduct(
        title: titleController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        category: selectedCategory.value,
      );

      Get.find<ProductController>().products.insert(0, product);

      Get.snackbar("Success", "Product Added Successfully");

      Get.back(result: true);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
