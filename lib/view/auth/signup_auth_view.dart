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
import 'package:taskcommerceapp/utilies/vaildator.dart';
import 'package:taskcommerceapp/view/auth/login_auth_view.dart';
import 'package:taskcommerceapp/viewmodel/auth/auth_controller_viewmodel.dart';

class SignupAuthView extends StatelessWidget {
  SignupAuthView({super.key});

  final AuthController _authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                CustomtextComponents(
                  title: 'Sign Up',
                  size: 24.sp,
                  weight: FontWeight.w800,
                ),
                SizedBox(height: 16.h),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Name input
                      CustomFieldComponents(
                        keyboardType: TextInputType.name,
                        controller: _authController.signupNameController.value,
                        prefixIcon: Icons.person,
                        hint: 'Your Name',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name is required';
                          }
                          return Utils.validateNames(value);
                        },
                      ),
                      SizedBox(height: 18.h),

                      // Email input
                      CustomFieldComponents(
                        keyboardType: TextInputType.emailAddress,
                        controller: _authController.signupEmailController.value,
                        prefixIcon: Icons.email,
                        hint: 'Email Address',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                          return Utils.validateEmail(value);
                        },
                      ),
                      SizedBox(height: 18.h),

                      // Password input
                      CustomFieldComponents(
                        keyboardType: TextInputType.text,
                        controller:
                            _authController.signupPasswordController.value,
                        prefixIcon: Icons.lock,
                        hint: 'Khan1234@',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          return Utils.validatePassword(value);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),

                // Sign up button with loading indicator
                Obx(
                  () => CustomButtonComponents(
                    isLoading: _authController.isLoading.value,
                    weight: FontWeight.w500,
                    size: 16.sp,
                    width: double.infinity,
                    btnName: 'Sign Up',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // Set the loading state to true
                        _authController.isLoading.value = true;

                        try {
                          // Call sign-up method
                          await _authController.signUp();

                          // If successful, navigate to login screen
                          if (_authController.user.value != null) {
                            Get.snackbar("Success", "Sign Up Successful");
                            Get.offAllNamed(RouteName.home);
                          } else {
                            // Handle any error if sign-up failed
                            Get.snackbar("Error", "Sign Up Failed. Please try again.");
                          }
                        } catch (e) {
                          // Handle exceptions and show error message
                          Get.snackbar("Error", e.toString());
                        } finally {
                          // Reset loading state
                          _authController.isLoading.value = false;
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: 30.h),

                // Already have an account - Navigate to login screen
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
                        TextSpan(text: "Already have an account?"),
                        TextSpan(
                          text: " Sign in",
                          style: TextStyle(color: AppColor.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => LoginAuthView());
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
