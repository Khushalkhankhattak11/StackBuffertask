// ignore_for_file: deprecated_member_use, must_be_immutable

import 'package:flutter/services.dart'; // Import for SystemNavigator
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taskcommerceapp/res/color/appcolor.dart';
import 'package:taskcommerceapp/res/components/customtext_components.dart';
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
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CustomtextComponents(title: 'Commerce Store', size: 18.sp),
          actions: [
            IconButton(
              onPressed: () {
                Get.dialog(
                  barrierDismissible: false,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.w),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.sp),
                            child: Material(
                              child: Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  CustomtextComponents(
                                    title: 'Are you sure want to Logout',

                                    size: 16.sp,
                                    weight: FontWeight.bold,
                                  ),
                                  SizedBox(height: 15.h),

                                  //Buttons
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          child: const Text('NO'),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(0.w, 45.h),
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                          ),
                                          onPressed: () {
                                            Get.close(1);
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: ElevatedButton(
                                          child: const Text('YES'),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size(0.w, 45.h),
                                            backgroundColor:
                                                AppColor.greenColor,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                            ),
                                          ),
                                          onPressed: () {
                                            authController.logout();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
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
                padding: EdgeInsets.all(8.sp),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two products per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.73, // Adjust aspect ratio for card layout
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
