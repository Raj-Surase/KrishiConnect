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

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: ListView.builder(
        itemCount: provider.crops.length,
        itemBuilder: (context, index) {
          final crop = provider.crops[index];
          return Card(
            child: ListTile(
              leading: crop.imageUrl != null
                  ? Image.network(crop.imageUrl!, height: 40.h, width: 40.h)
                  : Icon(Icons.grass_rounded),
              title: Text(crop.name),
            ),
          );
        },
      ),
    );
  }
}
