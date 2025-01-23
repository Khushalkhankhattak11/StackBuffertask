import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFieldComponents extends StatelessWidget {
  final String hint;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final VoidCallback? onPressed;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? labelWidget;
  final bool enabled;

  const CustomFieldComponents({
    super.key,
    required this.hint,
    this.suffixIcon,
    this.enabled = false,
    this.inputFormatters,
    this.prefixIcon,
    this.onPressed,
    this.validator,
    this.labelWidget,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: enabled,
      onTapOutside: (v) {
        FocusScope.of(context).unfocus();
      },
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      style: GoogleFonts.dmSans(
        fontSize: 14.sp,
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      obscureText: obscureText,
      decoration: InputDecoration(
        label: labelWidget,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 16.sp),
        focusColor: Colors.white,
        hintText: hint,
        hintStyle: GoogleFonts.dmSans(
          fontSize: 14.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: prefixIcon != null
            ? Padding(
          padding: EdgeInsets.only(left: 12.w, right: 8.w),
          child: Icon(
            prefixIcon,
            size: 24.sp,
            color: Colors.black,
          ),
        )
            : null,
        suffixIcon: suffixIcon != null
            ? Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              suffixIcon,
              size: 24.sp,
              color: Colors.black,
            ),
          ),
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(
            color: const Color(0xffE2E4EA),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(15.0.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(
            color: const Color(0xffE2E4EA),
          ),
        ),
        errorStyle: const TextStyle(color: Colors.red, height: 0),
      ),
      controller: controller,
      validator: validator,
      onChanged: onChanged,
    );
  }
}
