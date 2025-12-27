// user_navigator.dart (UPDATED)

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/custom_widgets/logout_dialog.dart';
import 'package:provider/provider.dart';

import 'package:krishi_connect/core/custom_widgets/custom_scaffold.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';
import 'package:krishi_connect/core/utils/app_assets.dart';

import 'package:krishi_connect/provider/weather_provider.dart';
import 'package:krishi_connect/provider/farmer_provider.dart';

import 'package:krishi_connect/screen/user/user_home_screen.dart';
import 'package:krishi_connect/screen/user/user_query_screen.dart';
import 'package:krishi_connect/screen/user/user_schemes_screen.dart';
import 'package:krishi_connect/screen/user/user_market_rate_screen.dart';

class UserNavigator extends StatefulWidget {
  const UserNavigator({super.key});

  @override
  State<UserNavigator> createState() => _UserNavigatorState();
}

class _UserNavigatorState extends State<UserNavigator> {
  int _currentIndex = 0;

  final _screens = const [
    UserHomeScreen(),
    UserQueryScreen(),
    UserSchemesScreen(),
    UserMarketRateScreen(),
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      context.read<WeatherProvider>().fetchFutureWeather(
        location: "Kopargaon",
        date: "2026-01-15",
      );

      context.read<FarmerProvider>().initialize(); // ✅ SAFE
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(height: 40.h, child: Image.asset(AppAssets.appLogo)),
            10.horizontalSpace,
            Text(
              "KrishiConnect",
              style: context.textTheme.headlineSmall?.copyWith(
                color: context.colorTheme.primary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => showLogoutDialog(context),
            icon: Icon(
              Icons.person_rounded,
              color: context.colorTheme.onSurface,
              size: 24.sp,
            ),
          ),
          20.horizontalSpace,
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: context.colorTheme.primary,
        unselectedItemColor: context.colorTheme.onSurface.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_rounded),
            label: "Assistant",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: "Schemes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: "Market",
          ),
        ],
      ),
    );
  }
}
