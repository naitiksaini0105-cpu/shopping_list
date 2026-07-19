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

  final brandController = TextEditingController();
  final imageController = TextEditingController();
  final ratingController = TextEditingController();
  final stockController = TextEditingController();

  var selectedCategory = ''.obs;

  final imageUrl = ''.obs;

  var isLoading = false.obs;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    // selectedCategory is an RxString (observable); it doesn't have dispose()
    // and will be cleaned up by GetX when the controller is removed.
    brandController.dispose();
    imageController.dispose();
    ratingController.dispose();
    stockController.dispose();
    super.dispose();
  }

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

        brand: brandController.text.isEmpty ? null : brandController.text,

        image: imageController.text.isEmpty ? null : imageController.text,

        rating: ratingController.text.isEmpty
            ? null
            : double.parse(ratingController.text),

        stock: stockController.text.isEmpty
            ? null
            : int.parse(stockController.text),
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
