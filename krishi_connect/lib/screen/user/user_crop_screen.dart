// user_crop_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:krishi_connect/provider/farmer_provider.dart';

class UserCropScreen extends StatelessWidget {
  const UserCropScreen({super.key});

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
      itemCount: provider.crops.length,
      itemBuilder: (context, index) {
        final crop = provider.crops[index];
        return Card(
          child: ListTile(
            leading: crop.imageUrl != null
                ? Image.network(crop.imageUrl!, height: 20.h, width: 20.h)
                : Icon(Icons.grass_rounded),
            title: Text(crop.name),
            subtitle: Text(crop.details ?? "No details available"),
          ),
        );
      },
    );
  }
}
