import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Keep this file minimal: single place for shared shadow styles
class AppShadows {
  static const List<BoxShadow> toggleBackground = [
    BoxShadow(color: Color(0xffB8BEC7), blurRadius: 6, offset: Offset(3, 3)),
    BoxShadow(color: Colors.white, blurRadius: 6, offset: Offset(-3, -3)),
  ];

  static const List<BoxShadow> toggleIndicator = [
    BoxShadow(color: Color(0xffB8BEC7), blurRadius: 5, offset: Offset(2, 2)),
    BoxShadow(color: Colors.white, blurRadius: 5, offset: Offset(-2, -2)),
  ];

  static BoxShadow get softCard => BoxShadow(
    color: const Color(0xff1F2C37).withOpacity(0.08),
    blurRadius: 16.r,
    offset: const Offset(0, 6),
  );
}
