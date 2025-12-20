import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/provider/theme_provider.dart';
import 'package:krishi_connect/core/routes/app_router.dart';
import 'package:krishi_connect/core/theme/app_theme.dart';
import 'package:krishi_connect/provider/api_provider.dart';
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

        /// 🔥 GENERATED OPENAPI PROVIDER
        ChangeNotifierProvider(create: (_) => ApiProvider()),
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
