import 'package:flutter/material.dart';
import 'package:krishi_connect/core/custom_widgets/custom_scaffold.dart';
import 'package:krishi_connect/core/utils/app_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Image.asset(AppAssets.appBanner)));
  }
}
