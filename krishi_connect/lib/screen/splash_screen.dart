import 'package:flutter/material.dart';
import 'package:krishi_connect/core/routes/app_router.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'package:krishi_connect/core/custom_widgets/custom_scaffold.dart';
import 'package:krishi_connect/core/utils/app_assets.dart';
import 'package:krishi_connect/provider/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initAuth();
    });
  }

  Future<void> _initAuth() async {
    final auth = context.read<AuthProvider>();
    final restored = await auth.restoreSession();

    if (!mounted) return;

    // ✅ short splash delay (800ms–1200ms is ideal)
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    if (!restored) {
      context.go(AppRouter.authRoute);
      return;
    }

    /// Navigate by role
    if (auth.user?.role == 'admin') {
      context.go(AppRouter.adminHomeScreenRoute);
    } else {
      context.go(AppRouter.userHomeScreenRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(body: Center(child: Image.asset(AppAssets.appBanner)));
  }
}
