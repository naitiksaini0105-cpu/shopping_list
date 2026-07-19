import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_demo/controller/product_controller.dart';
import 'package:shopping_demo/model/product_model.dart';
import 'package:shopping_demo/screens/edit_product.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ProductController productController = Get.find<ProductController>();
  late Product currentProduct;

  @override
  void initState() {
    super.initState();
    currentProduct = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        actions: [
          IconButton(
            onPressed: () async {
              final updatedProduct = await Get.to(
                () => EditProductScreen(product: currentProduct),
              );
              print("Received:");
              print(updatedProduct);

              if (updatedProduct != null && updatedProduct is Product) {
                setState(() {
                  currentProduct = updatedProduct;
                  print(currentProduct.title);
                });
              }
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Card(
              child: Center(
                child: Image.network(
                  widget.product.thumbnail.isNotEmpty
                      ? currentProduct.thumbnail
                      : 'https://via.placeholder.com/150',
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              currentProduct.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            Text(
              '-----------------------------------------------------------------------------------',
            ),

            Text(currentProduct.description),

            const SizedBox(height: 20),

            Text(
              "Price : \$${currentProduct.price}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),
            if (currentProduct.brand.isNotEmpty)
              Text(
                "Brand : ${currentProduct.brand}",
                style: const TextStyle(fontSize: 18),
              )
            else
              Text('Brand : UnKnown', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),

            Text(
              "Category : ${currentProduct.category}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Rating : ${currentProduct.rating}",
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              "Stock : ${currentProduct.stock}",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
