import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_demo/controller/product_details.dart';
import 'package:shopping_demo/controller/product_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  ProductDetailScreen({super.key, required this.productId});

  final ProductDetailController controller = Get.put(ProductDetailController());
  final ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    controller.fetchProduct(productId);

    return Scaffold(
      appBar: AppBar(title: const Text("Product Details")),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        final product = controller.product.value!;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Card(
                child: Center(
                  child: Image.network(product.thumbnail, height: 250),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                product.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),
              Text(
                '-----------------------------------------------------------------------------------',
              ),

              Text(product.description),

              const SizedBox(height: 20),

              Text(
                "Price : \$${product.price}",
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 10),

              Text(
                "Brand : ${product.brand}",
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 10),

              Text(
                "Category : ${product.category}",
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 10),

              Text(
                "Rating : ${product.rating}",
                style: const TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 10),

              Text(
                "Stock : ${product.stock}",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      }),
    );
  }
}
