import 'package:flutter/material.dart';
import 'package:shopping_demo/screens/tab%20.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// Background Image
          SizedBox.expand(
            child: Image.asset(
              "assets/images/Screenshot 2026-07-13 092139.png",
              fit: BoxFit.cover,
            ),
          ),

          /// Black Overlay
          Container(color: Colors.black.withOpacity(.25)),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  /// Logo
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.shopping_bag,
                          color: Colors.orange,
                          size: 18,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "ShoppingApp",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  Spacer(),

                  /// Bottom Card
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Color(0xff1E1E1E),
                      borderRadius: BorderRadius.circular(30),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "A fresh\napproach\n",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextSpan(
                                text: "to ",
                                style: TextStyle(color: Colors.white),
                              ),
                              TextSpan(
                                text: "shopping",
                                style: TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 18),

                        Text(
                          "Welcome to our shopping app, where convenience meets style. Explore products and shop confidently.",
                          style: TextStyle(color: Colors.white70, height: 1.5),
                        ),

                        SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: StadiumBorder(),
                            ),
                            onPressed: () {
                              Get.to(() => TabScreen());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.shopping_bag_outlined,
                                    color: Colors.orange,
                                  ),
                                ),

                                SizedBox(width: 15),

                                Text(
                                  "Get Started",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),

                                SizedBox(width: 15),

                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
