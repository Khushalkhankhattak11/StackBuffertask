import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:taskcommerceapp/model/product_model.dart';
import 'package:taskcommerceapp/res/color/appcolor.dart';
import 'package:taskcommerceapp/res/components/customtext_components.dart';
import 'package:taskcommerceapp/view/details/details_view.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the product detail screen
        Get.to(() => ProductDetailScreen(product: product));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                product.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: CustomtextComponents(
                title: product.name,
                size: 16.sp,
                weight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: CustomtextComponents(
                title: "\$${product.price.toStringAsFixed(2)}",
                color: AppColor.primaryColor,
                weight: FontWeight.bold,
                size: 14.sp,
              ),
            ),
            Padding(
              padding:  EdgeInsets.all(8.sp),
              child: CustomtextComponents(
                title: product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,

                color: AppColor.greyColor,
                size: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
