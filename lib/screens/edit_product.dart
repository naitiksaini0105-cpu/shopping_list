import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_demo/model/product_model.dart';
import 'package:shopping_demo/controller/product_controller.dart';
import 'package:shopping_demo/controller/edit_product.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final EditProductController controller = Get.put(EditProductController());

  final ProductController productController = Get.find<ProductController>();

  InputDecoration decoration({required String label, required IconData icon}) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.loadProduct(widget.product);
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product"), centerTitle: true),

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
                decoration: decoration(label: "Title", icon: Icons.title),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter title";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              /// Description
              TextFormField(
                controller: controller.descriptionController,
                maxLines: 4,
                decoration: decoration(
                  label: "Description",
                  icon: Icons.description,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter description";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              /// Price & Stock
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.priceController,
                      keyboardType: TextInputType.number,
                      decoration: decoration(
                        label: "Price",
                        icon: Icons.currency_rupee,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter price";
                        }

                        if (double.tryParse(value) == null) {
                          return "Invalid";
                        }

                        return null;
                      },
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: TextFormField(
                      controller: controller.stockController,
                      keyboardType: TextInputType.number,
                      decoration: decoration(
                        label: "Stock",
                        icon: Icons.inventory,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }

                        if (int.tryParse(value) == null) {
                          return "Invalid";
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Brand & Rating
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.brandController,
                      decoration: decoration(
                        label: "Brand",
                        icon: Icons.business,
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: TextFormField(
                      controller: controller.ratingController,
                      keyboardType: TextInputType.number,
                      decoration: decoration(label: "Rating", icon: Icons.star),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
                        }

                        if (double.tryParse(value) == null) {
                          return "Invalid";
                        }

                        return null;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// Category
              Obx(
                () => DropdownButtonFormField<String>(
                  initialValue:
                      productController.categories.contains(
                        controller.selectedCategory.value,
                      )
                      ? controller.selectedCategory.value
                      : null,

                  decoration: decoration(
                    label: "Category",
                    icon: Icons.category,
                  ),

                  items: productController.categories
                      .where((e) => e != "All Products")
                      .map(
                        (category) => DropdownMenuItem<String>(
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
                      return "Select category";
                    }

                    return null;
                  },
                ),
              ),

              const SizedBox(height: 16),

              /// Image URL
              TextFormField(
                controller: controller.imageController,
                decoration: decoration(label: "Image URL", icon: Icons.image),
                onChanged: (value) {
                  controller.imageController.text = value;
                },
              ),

              const SizedBox(height: 30),

              /// Button
              SizedBox(
                width: double.infinity,

                child: Obx(
                  () => ElevatedButton.icon(
                    icon: controller.isLoading.value
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(Icons.add),

                    label: Text(
                      controller.isLoading.value
                          ? "updating..."
                          : "update Product",
                      style: const TextStyle(fontSize: 18),
                    ),

                    onPressed: controller.isLoading.value
                        ? null
                        : controller.updateProduct,

                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
