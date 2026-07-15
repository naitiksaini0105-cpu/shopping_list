import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_demo/controller/add_product.dart';
import 'package:shopping_demo/controller/product_controller.dart';

class AddProductScreen extends StatelessWidget {
  AddProductScreen({super.key});

  final AddProductController controller = Get.put(AddProductController());
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Form(
          key: controller.formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              TextFormField(
                controller: controller.titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter title";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// Description
              TextFormField(
                controller: controller.descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter description";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// Price
              TextFormField(
                controller: controller.priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Price",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Price";
                  }

                  if (double.tryParse(value) == null) {
                    return "Invalid Price";
                  }

                  return null;
                },
              ),

              const SizedBox(height: 20),

              /// Category
              Obx(
                () => DropdownButtonFormField<String>(
                  initialValue: controller.selectedCategory.value.isEmpty
                      ? null
                      : controller.selectedCategory.value,

                  decoration: const InputDecoration(
                    labelText: "Category",
                    border: OutlineInputBorder(),
                  ),

                  items: productController.categories
                      .where((e) => e != "All Products")
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ),
                      )
                      .toList(),

                  onChanged: (value) {
                    controller.selectedCategory.value = value!;
                  },

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Select Category";
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 30),

              /// Submit Button
              SizedBox(
                width: double.infinity,

                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.submitProduct,

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),

                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text(
                            "Add Product",
                            style: TextStyle(fontSize: 18),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
