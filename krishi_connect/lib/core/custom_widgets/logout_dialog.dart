import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:krishi_connect/core/routes/app_router.dart';
import 'package:krishi_connect/provider/auth_provider.dart';
import 'package:provider/provider.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();

              await context.read<AuthProvider>().logout();

              if (!context.mounted) return;
              context.go(AppRouter.authRoute);
            },
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
