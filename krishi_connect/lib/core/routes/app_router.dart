import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:krishi_connect/screen/admin/admin_home.dart';
import 'package:krishi_connect/screen/auth/authentication_screen.dart';
import 'package:krishi_connect/screen/splash_screen.dart';
import 'package:krishi_connect/screen/user/user_home.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static const String splashRoute = '/splash';
  static const String authRoute = '/auth';

  static const String userHomeRoute = '/user';

  static const String adminHomeRoute = '/admin';

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: authRoute,
    routes: [
      GoRoute(
        path: splashRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: authRoute,
        builder: (context, state) => const AuthenticationScreen(),
      ),
      GoRoute(
        path: userHomeRoute,
        builder: (context, state) => const UserHome(),
      ),
      GoRoute(
        path: adminHomeRoute,
        builder: (context, state) => const AdminHome(),
      ),
    ],
  );
}
