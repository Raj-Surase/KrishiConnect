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

        /// ✅ PROVIDE ApiClient FIRST
        Provider<ApiClient>(
          create: (_) => ApiClient(basePath: "http://10.146.133.249:8000"),
        ),

        /// ✅ ApiProvider depends on ApiClient
        ChangeNotifierProxyProvider<ApiClient, ApiProvider>(
          create: (context) => ApiProvider(context.read<ApiClient>()),
          update: (_, apiClient, __) => ApiProvider(apiClient),
        ),

        /// ✅ AuthProvider
        ChangeNotifierProxyProvider<ApiClient, AuthProvider>(
          create: (context) => AuthProvider(context.read<ApiClient>()),
          update: (_, apiClient, __) => AuthProvider(apiClient),
        ),

        /// ✅ AdminProvider
        ChangeNotifierProxyProvider<ApiClient, AdminProvider>(
          create: (context) => AdminProvider(context.read<ApiClient>()),
          update: (_, apiClient, __) => AdminProvider(apiClient),
        ),

        /// ✅ FarmerProvider (ERROR FIXED HERE)
        ChangeNotifierProxyProvider<ApiClient, FarmerProvider>(
          create: (context) => FarmerProvider(context.read<ApiClient>()),
          update: (_, apiClient, __) => FarmerProvider(apiClient),
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
