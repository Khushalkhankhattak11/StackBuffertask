import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:taskcommerceapp/res/color/appcolor.dart';
import 'package:taskcommerceapp/res/components/custom_button_components.dart';
import 'package:taskcommerceapp/res/components/custom_formfield_component.dart';
import 'package:taskcommerceapp/res/components/customtext_components.dart';
import 'package:taskcommerceapp/res/routes/routesname.dart';
import 'package:taskcommerceapp/viewmodel/auth/auth_controller_viewmodel.dart';
import '../../utilies/vaildator.dart';

class LoginAuthView extends StatelessWidget {
  LoginAuthView({super.key});

  final AuthController _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 120.h),
                CustomtextComponents(
                  title: 'Sign In',
                  size: 24.sp,
                  weight: FontWeight.w800,
                ),
                SizedBox(height: 16.h),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomFieldComponents(
                        keyboardType: TextInputType.emailAddress,
                        controller: _authController.loginEmailController.value,
                        obscureText: false,
                        prefixIcon: Icons.email,
                        hint: 'Email Address',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email cannot be empty';
                          }
                          return Utils.validateEmail(value);
                        },
                      ),
                      SizedBox(height: 18.h),
                      CustomFieldComponents(
                        keyboardType: TextInputType.text,
                        controller:
                            _authController.loginPasswordController.value,
                        obscureText: true,
                        prefixIcon: Icons.password,
                        hint: 'Password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return Utils.validatePassword(value);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),

                // Handle loading state with Obx
                Obx(
                  () => CustomButtonComponents(
                    isLoading:
                        _authController
                            .isLoading
                            .value, // Bind isLoading from controller
                    weight: FontWeight.w500,
                    size: 16.sp,
                    width: double.infinity,
                    btnName: 'Login',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        try {
                          // Start loading
                          _authController.isLoading.value = true;

                          // Attempt login
                          await _authController.login();

                          // Redirect to Home after successful login
                          if (_authController.user.value != null) {
                            Get.offAllNamed(
                              '/home',
                            ); // Replace with your home route
                          }
                        } catch (e) {
                          // Handle login errors (already handled in AuthController)
                        } finally {
                          // Ensure loading is reset
                          _authController.isLoading.value = false;
                        }
                      }
                    },
                  ),
                ),

                SizedBox(height: 30.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.textFiledTextColor,
                      ),
                      children: [
                        TextSpan(text: "Don't have an Account?"),
                        TextSpan(
                          text: " Create one",
                          style: TextStyle(color: AppColor.primaryColor),
                          recognizer:
                              TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(RouteName.signUp);
                                },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
