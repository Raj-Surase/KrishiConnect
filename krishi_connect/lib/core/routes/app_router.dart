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

  static const String UserHomeScreenRoute = '/user';

  static const String AdminHomeScreenRoute = '/admin';

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
        path: UserHomeScreenRoute,
        builder: (context, state) => const UserNavigator(),
      ),
      GoRoute(
        path: AdminHomeScreenRoute,
        builder: (context, state) => const AdminNavigator(),
      ),
    ],
  );
}
