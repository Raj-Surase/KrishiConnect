import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:krishi_connect/screen/admin/admin_home_screen.dart';
import 'package:krishi_connect/screen/admin/admin_navigator.dart';
import 'package:krishi_connect/screen/auth/authentication_screen.dart';
import 'package:krishi_connect/screen/splash_screen.dart';
import 'package:krishi_connect/screen/user/user_home_screen.dart';
import 'package:krishi_connect/screen/user/user_navigator.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static const String splashRoute = '/splash';
  static const String authRoute = '/auth';

  static const String userHomeScreenRoute = '/user';

  static const String adminHomeScreenRoute = '/admin';

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: splashRoute,
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
        path: userHomeScreenRoute,
        builder: (context, state) => const UserNavigator(),
      ),
      GoRoute(
        path: adminHomeScreenRoute,
        builder: (context, state) => const AdminNavigator(),
      ),
    ],
  );
}
