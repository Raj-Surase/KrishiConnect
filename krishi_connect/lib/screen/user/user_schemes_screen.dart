// user_schemes_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/custom_widgets/common_container.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:krishi_connect/provider/farmer_provider.dart';

class UserSchemesScreen extends StatelessWidget {
  const UserSchemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FarmerProvider>();

    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }

    return ListView.builder(
      itemCount: provider.schemes.length,
      padding: EdgeInsets.all(20.w),
      itemBuilder: (context, index) {
        final scheme = provider.schemes[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: CommonContainer(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.policy),
                      20.horizontalSpace,
                      Expanded(child: Text(scheme.title)),
                      10.horizontalSpace,
                      IconButton(
                        icon: const Icon(Icons.open_in_new),
                        onPressed: () => launchUrl(Uri.parse(scheme.link)),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Text(
                    scheme.description ?? "No description",
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
