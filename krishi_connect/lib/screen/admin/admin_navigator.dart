import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/custom_widgets/custom_scaffold.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';
import 'package:krishi_connect/core/utils/app_assets.dart';
import 'package:krishi_connect/screen/admin/admin_home_screen.dart';
import 'package:krishi_connect/screen/admin/admin_crop_screen.dart';
import 'package:krishi_connect/screen/admin/admin_schemes_screen.dart';
import 'package:krishi_connect/screen/admin/admin_market_rate_screen.dart';

class AdminNavigator extends StatefulWidget {
  const AdminNavigator({super.key});

  @override
  State<AdminNavigator> createState() => _AdminNavigatorState();
}

class _AdminNavigatorState extends State<AdminNavigator> {
  int _currentIndex = 0;

  final _screens = const [
    AdminHomeScreen(),
    AdminCropScreen(),
    AdminSchemesScreen(),
    AdminMarketRateScreen(),
  ];

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
            onPressed: () {},
            icon: Icon(
              Icons.person_rounded,
              color: context.colorTheme.onSurface,
              size: 24.sp,
            ),
          ),
          20.horizontalSpace,
        ],
      ),

      /// 🔥 KEEP STATE BETWEEN TABS
      body: IndexedStack(index: _currentIndex, children: _screens),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: context.colorTheme.primary,
        unselectedItemColor: context.colorTheme.onSurface.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.agriculture_rounded),
            label: "Crops",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_rounded),
            label: "Schemes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_rounded),
            label: "Market",
          ),
        ],
      ),
    );
  }
}
