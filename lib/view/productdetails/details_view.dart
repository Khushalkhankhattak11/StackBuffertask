// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taskcommerceapp/model/product_model.dart';
import 'package:taskcommerceapp/res/color/appcolor.dart';
import 'package:taskcommerceapp/res/components/custom_button_components.dart';
import 'package:taskcommerceapp/res/components/customtext_components.dart';
import 'package:taskcommerceapp/viewmodel/product/product_viewmodel.dart';
import 'package:taskcommerceapp/viewmodel/services/stripe_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({super.key, required this.product});

  final ProductController productController = Get.put(
    ProductController(),
  ); // Controller to manage loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => CustomButtonComponents(
            isLoading:
                productController
                    .isLoading
                    .value, // Bind isLoading from controller
            weight: FontWeight.w500,
            size: 16.sp,
            width: double.infinity,
            btnName: 'Pay Now',
            onPressed: () async {
              // Start loading before initiating payment
              productController.isLoading.value = true;
              try {
                // Initialize payment sheet for the specific product
                await StripeService.initPaymentSheet(
                  amount: product.price.toString(),
                  currency: "usd",
                  merchantDisplayName: "My Store",
                );
                // Show payment sheet
                await StripeService.presentPaymentSheet(context);
              } catch (e) {
                // Handle payment failure gracefully
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Payment failed: $e"),
                    backgroundColor: Colors.red,
                  ),
                );
              } finally {
                // Reset loading state after payment attempt
                productController.isLoading.value = false;
              }
            },
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(product.image, width: double.infinity, height: 300.h),
              SizedBox(height: 16.h),
              CustomtextComponents(
                title: product.name,
                size: 24.sp,
                weight: FontWeight.bold,
              ),

              SizedBox(height: 8.h),
              CustomtextComponents(
                title: "\$${product.price.toStringAsFixed(2)}",
                size: 20.sp.sp,
                color: AppColor.greenColor,
                weight: FontWeight.bold,
              ),
              SizedBox(height: 13.h),
              Text(
                product.description,
                style: TextStyle(fontSize: 16.sp, letterSpacing: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
