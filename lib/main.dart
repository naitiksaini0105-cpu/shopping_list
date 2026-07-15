import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopping_demo/controller/product_controller.dart';
import 'package:shopping_demo/controller/theme.dart';
import 'package:shopping_demo/screens/welcome.dart';

void main() {
  Get.put(ProductController());
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,

        theme: ThemeData.light(),

        darkTheme: ThemeData.dark(),

        themeMode: themeController.isDarkMode.value
            ? ThemeMode.dark
            : ThemeMode.light,

        home: WelcomeScreen(),
      ),
    );
  }
}
