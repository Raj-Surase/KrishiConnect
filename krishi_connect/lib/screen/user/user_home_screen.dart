import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/custom_widgets/common_container.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';
import 'package:krishi_connect/core/utils/app_assets.dart';

class UserHomeScreen extends StatelessWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello, {Username} {wave emoji}",
              style: context.textTheme.headlineSmall?.copyWith(
                color: context.colorTheme.onBackground,
              ),
            ),
            20.verticalSpace,
            CommonContainer(
              child: Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: 20.w,
                  vertical: 10.h,
                ),
                child: SizedBox(
                  height: 150.h,
                  child: Center(child: Text("Weather Widget")),
                ),
              ),
            ),
            20.verticalSpace,
            // Display more details according to the api.
          ],
        ),
      ),
    );
  }
}
