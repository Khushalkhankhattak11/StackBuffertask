// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomtextComponents extends StatelessWidget {
  final title;
  double size;
  final weight;
  final color;
  final decoration;
  final textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final double? letterSpacing; // Add letterSpacing here

  CustomtextComponents({
    super.key,
    required this.title,
    required this.size,
    this.weight,
    this.color,
    this.decoration,
    this.overflow,
    this.textAlign,
    this.maxLines,
    this.letterSpacing, // Accept letterSpacing as a parameter
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.dmSans(
        fontSize: kIsWeb ? size : size.sp,
        color: color,
        fontWeight: weight,
        decoration: decoration,
        letterSpacing: letterSpacing, // Pass letterSpacing to TextStyle
      ),
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis, // Default to ellipsis if no overflow is provided
      maxLines: maxLines, // Pass maxLines to Text widget
    );
  }
}
