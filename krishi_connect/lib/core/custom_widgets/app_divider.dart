import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.colorTheme.outline,
      height: 1,
      radius: BorderRadius.circular(20.r),
    );
  }
}
