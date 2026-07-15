import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:shopping_demo/controller/product_controller.dart';
import 'package:shopping_demo/widget/product_card.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

  final ProductController controller =
      Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: Obx(() {
        final favorites = controller.favoriteProducts;

        if (favorites.isEmpty) {
          return const Center(
            child: Text("No Favorite Products"),
          );
        }

        return ListView.builder(
          itemCount: favorites.length,
          itemBuilder: (_, index) {
            return ProductCard(
              product: favorites[index],
            );
          },
        );
      }),
    );
  }
}