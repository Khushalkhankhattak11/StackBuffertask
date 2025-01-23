// ignore_for_file: unnecessary_null_comparison, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskcommerceapp/res/color/appcolor.dart';
import 'package:taskcommerceapp/res/components/customtext_components.dart';


class CustomButtonComponents extends StatelessWidget {
  double? width;
  final weight;

  final size;
  final String btnName;
  final bool isLoading;
  final VoidCallback onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final BorderRadius? borderRadius; // New optional parameter for borderRadius

 CustomButtonComponents({
    super.key,
    required this.btnName,
    this.width,
    required this.onPressed,
    this.buttonColor,
    required this.isLoading,
    this.textColor,
    this.size,
    this.borderColor,
    this.weight,
    this.borderRadius, // Initialize borderRadius parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 4.h),
      child: GestureDetector(
        onTap: isLoading || onPressed == null ? null : onPressed,
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: 60.h,
          decoration: BoxDecoration(
            color: buttonColor ??AppColor.primaryColor,
            borderRadius: borderRadius ??
                BorderRadius.circular(20
                    .sp), // Use provided borderRadius or default circular with radius 20.sp
            border: Border.all(
              color: borderColor ?? Colors.transparent,
            ),
          ),
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: 40.0, // Adjust the height
                    width: 40.0, // Adjust the width
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor:
                          Colors.white, // Background color (optional)
                      strokeWidth: 4.0, // Adjust the thickness of the indicator
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white), // Set color to white
                    ),
                  ),
                )
              : CustomtextComponents(
                  title: btnName,
                  size: size,
                  color: textColor ?? AppColor.whiteColor,
                  weight: weight,
                ),
        ),
      ),
    );
  }
}
