// user_market_rate_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:krishi_connect/provider/farmer_provider.dart';

class UserMarketRateScreen extends StatelessWidget {
  const UserMarketRateScreen({super.key});

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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      itemCount: provider.marketRates.length,
      itemBuilder: (context, index) {
        final rate = provider.marketRates[index];
        return Card(
          child: ListTile(
            leading: const Icon(Icons.currency_rupee),
            title: Text(rate.location),
            subtitle: Text(
              "₹${rate.minPrice} - ₹${rate.maxPrice} / ${rate.unit}",
            ),
            trailing: Text(DateFormat('dd MMM').format(rate.date)),
          ),
        );
      },
    );
  }
}
