// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/services.dart'; // Import for SystemNavigator
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskcommerceapp/res/components/product_card_components.dart';
import 'package:taskcommerceapp/viewmodel/auth/auth_controller_viewmodel.dart';
import 'package:taskcommerceapp/viewmodel/product/product_viewmodel.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  AuthController authController = Get.find<AuthController>();
  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent back navigation if you want to close the app instead
        SystemNavigator.pop(); // This will close the app
        return false; // Return false to prevent the default back action
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            
            IconButton(
              onPressed: () {
                authController.logout();
              },
              icon: Icon(Icons.logout),
            ),
          ],
       
        ),
        body: ListView(
          children: [
            Obx(() {
              if (productController.productList.isEmpty) {
                return const Center(child: Text('No products available'));
              }

              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two products per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75, // Adjust aspect ratio for card layout
                ),
                itemCount: productController.productList.length,
                itemBuilder: (context, index) {
                  final product = productController.productList[index];
                  return ProductCard(product: product);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
