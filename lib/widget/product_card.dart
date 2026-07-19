import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_demo/screens/product_details.dart';
import 'package:shopping_demo/controller/product_controller.dart';
import 'package:shopping_demo/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({super.key, required this.product});

  final ProductController controller = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),

        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            product.thumbnail,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return const Icon(Icons.image_not_supported, size: 50);
            },
          ),
        ),

        title: Text(
          product.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        subtitle: Text(
          "\$${product.price}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () {
                controller.toggleFavorite(product.id);
              },
            ),

            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                Get.defaultDialog(
                  title: "Delete Product",
                  titlePadding: EdgeInsets.only(top: 18),
                  middleText: "Are you sure you want to delete this product?",
                  contentPadding: EdgeInsets.all(15),

                  textCancel: "Cancel",
                  textConfirm: "Delete",
                  confirmTextColor: Colors.white,

                  onConfirm: () {
                    Get.back();
                    controller.deleteProduct(product.id);
                  },
                );
              },
            ),
          ],
        ),

        onTap: () {
          Get.to(() => ProductDetailScreen(product: product));
        },
      ),
    );
  }
}
