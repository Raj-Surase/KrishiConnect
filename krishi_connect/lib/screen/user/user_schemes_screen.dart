// user_schemes_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:krishi_connect/provider/farmer_provider.dart';

class UserSchemesScreen extends StatelessWidget {
  const UserSchemesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FarmerProvider>();

    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.schemes.length,
      itemBuilder: (context, index) {
        final scheme = provider.schemes[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.policy),
            title: Text(scheme.title),
            subtitle: Text(scheme.description ?? "No description"),
            trailing: IconButton(
              icon: const Icon(Icons.open_in_new),
              onPressed: () => launchUrl(Uri.parse(scheme.link)),
            ),
          ),
        );
      },
    );
  }
}
