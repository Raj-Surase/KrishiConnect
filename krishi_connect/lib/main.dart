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
import 'package:krishi_connect/provider/gemini_provider.dart';
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
        ChangeNotifierProvider(create: (_) => GeminiProvider()),

        /// ✅ SINGLE ApiClient INSTANCE
        Provider<ApiClient>(
          create: (_) => ApiClient(basePath: "http://10.247.87.249:8000"),
        ),

        /// ✅ ApiProvider (REUSED)
        ChangeNotifierProxyProvider<ApiClient, ApiProvider>(
          create: (context) => ApiProvider(context.read<ApiClient>()),
          update: (_, apiClient, apiProvider) {
            apiProvider!.updateApiClient(apiClient);
            return apiProvider;
          },
        ),

        /// ✅ AuthProvider (ALREADY FIXED)
        ChangeNotifierProxyProvider<ApiClient, AuthProvider>(
          create: (context) => AuthProvider(context.read<ApiClient>()),
          update: (_, apiClient, authProvider) {
            authProvider!.updateApiClient(apiClient);
            return authProvider;
          },
        ),

        /// ✅ AdminProvider
        ChangeNotifierProxyProvider<ApiClient, AdminProvider>(
          create: (context) => AdminProvider(context.read<ApiClient>()),
          update: (_, apiClient, adminProvider) {
            adminProvider!.updateApiClient(apiClient);
            return adminProvider;
          },
        ),

        /// ✅ FarmerProvider
        ChangeNotifierProxyProvider<ApiClient, FarmerProvider>(
          create: (context) => FarmerProvider(context.read<ApiClient>()),
          update: (_, apiClient, farmerProvider) {
            farmerProvider!.updateApiClient(apiClient);
            return farmerProvider;
          },
        ),

        ChangeNotifierProvider(create: (_) => WeatherProvider()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, _) {
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
