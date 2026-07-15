import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_demo/controller/product_controller.dart';

class CategoryChoiceChips extends StatelessWidget {
  CategoryChoiceChips({super.key});

  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            /// All Products Chip
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: ChoiceChip(
                label: const Text("All Products"),
                selected: controller.selectedCategory.value == "",
                onSelected: (_) {
                  controller.selectedCategory.value = "";
                  controller.fetchProducts();
                },
              ),
            ),

            /// Categories from API
            ...controller.categories.map(
              (category) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: ChoiceChip(
                  label: Text(category),
                  selected: controller.selectedCategory.value == category,
                  onSelected: (_) {
                    controller.filterCategory(category);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
