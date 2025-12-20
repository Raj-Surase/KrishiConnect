import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/provider/theme_provider.dart';
import 'package:krishi_connect/core/routes/app_router.dart';
import 'package:krishi_connect/core/theme/app_theme.dart';
import 'package:krishi_connect/provider/admin_provider.dart';
import 'package:krishi_connect/provider/api_provider.dart';
import 'package:krishi_connect/provider/auth_provider.dart';
import 'package:krishi_connect/provider/farmer_provider.dart';
import 'package:krishi_connect/provider/weather_provider.dart';
import 'package:krishi_connect/repo/api.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const KrishiConnectApp());
}

class KrishiConnectApp extends StatelessWidget {
  const KrishiConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),

        ChangeNotifierProvider(create: (_) => ApiProvider()),
        ChangeNotifierProxyProvider<ApiClient, AuthProvider>(
          create: (context) => AuthProvider(context.read<ApiClient>()),
          update: (_, api, __) => AuthProvider(api),
        ),
        ChangeNotifierProxyProvider<ApiClient, AdminProvider>(
          create: (context) => AdminProvider(context.read<ApiClient>()),
          update: (_, api, __) => AdminProvider(api),
        ),
        ChangeNotifierProxyProvider<ApiClient, FarmerProvider>(
          create: (context) => FarmerProvider(context.read<ApiClient>()),
          update: (_, api, __) => FarmerProvider(api),
        ),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: context.watch<ThemeProvider>().themeMode,
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
