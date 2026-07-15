import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_demo/controller/product_controller.dart';
import 'package:shopping_demo/screens/add_products.dart';
import 'package:shopping_demo/widget/category_choiceChip.dart';
import 'package:shopping_demo/widget/product_card.dart';
import 'package:shopping_demo/controller/theme.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final ProductController controller = Get.put(ProductController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Management"),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag),
                    Text(
                      "Product Management",
                      style: TextStyle(fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),

            Obx(
              () => SwitchListTile(
                title: const Text("Dark Mode"),

                secondary: const Icon(Icons.dark_mode),

                value: themeController.isDarkMode.value,

                onChanged: (value) {
                  themeController.toggleTheme();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.to(() => AddProductScreen());

          if (result == true) {
            controller.fetchProducts();
          }
        },
        child: const Icon(Icons.add),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        return RefreshIndicator(
          onRefresh: controller.fetchProducts,

          child: Column(
            children: [
              /// Search Field
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: controller.searchController,

                  decoration: InputDecoration(
                    hintText: "Search Products",

                    prefixIcon: const Icon(Icons.search),

                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: controller.clearSearch,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),

                  textInputAction: TextInputAction.search,

                  onSubmitted: (value) {
                    controller.searchProduct(value);
                  },
                ),
              ),

              /// Category Chips
              CategoryChoiceChips(),

              const SizedBox(height: 10),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedSort.value,

                    decoration: const InputDecoration(
                      labelText: "Sort By",
                      border: OutlineInputBorder(),
                    ),

                    items: const [
                      DropdownMenuItem(
                        value: "Default",
                        child: Text("Default"),
                      ),
                      DropdownMenuItem(
                        value: "Price (Low to High)",
                        child: Text("Price (Low to High)"),
                      ),
                      DropdownMenuItem(
                        value: "Price (High to Low)",
                        child: Text("Price (High to Low)"),
                      ),
                      DropdownMenuItem(value: "Rating", child: Text("Rating (High to Low)")),
                      DropdownMenuItem(
                        value: "Name (A-Z)",
                        child: Text("Name (A-Z)"),
                      ),
                    ],

                    onChanged: (value) {
                      if (value != null) {
                        controller.sortProducts(value);
                      }
                    },
                  ),
                ),
              ),

              /// Product List
              Expanded(
                child: controller.products.isEmpty
                    ? const Center(child: Text("No Products Found"))
                    : ListView.builder(
                        itemCount: controller.products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: controller.products[index],
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
