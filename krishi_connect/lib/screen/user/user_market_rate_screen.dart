// user_market_rate_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/custom_widgets/common_container.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:krishi_connect/provider/farmer_provider.dart';

class UserMarketRateScreen extends StatefulWidget {
  const UserMarketRateScreen({super.key});

  @override
  State<UserMarketRateScreen> createState() => _UserMarketRateScreenState();
}

class _UserMarketRateScreenState extends State<UserMarketRateScreen> {
  String? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FarmerProvider>();

    if (provider.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }

    /// ✅ Unique locations from market rates
    final locations =
        provider.marketRates.map((e) => e.location).toSet().toList()..sort();

    /// ✅ Filter by selected location
    final filteredRates = _selectedLocation == null
        ? provider.marketRates
        : provider.marketRates
              .where((e) => e.location == _selectedLocation)
              .toList();

    /// ✅ Crop lookup map (id → name)
    final cropMap = {for (final crop in provider.crops) crop.id: crop.name};

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          /// 🔽 LOCATION DROPDOWN
          DropdownButtonFormField<String>(
            value: _selectedLocation,
            hint: const Text("Select Location"),
            isExpanded: true,
            items: locations
                .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
                .toList(),
            onChanged: (value) {
              setState(() => _selectedLocation = value);
            },
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.location_on_outlined),
              border: OutlineInputBorder(),
            ),
          ),

          15.verticalSpace,

          /// 📋 MARKET RATE LIST
          Expanded(
            child: filteredRates.isEmpty
                ? const Center(child: Text("No market rates available"))
                : ListView.builder(
                    itemCount: filteredRates.length,
                    itemBuilder: (context, index) {
                      final rate = filteredRates[index];

                      final cropName = cropMap[rate.cropId] ?? "Unknown Crop";

                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: CommonContainer(
                          child: ListTile(
                            leading: const Icon(Icons.currency_rupee),
                            title: Text(
                              cropName,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle: Text(
                              "₹${rate.minPrice} - ₹${rate.maxPrice} / ${rate.unit}",
                            ),
                            trailing: Text(
                              DateFormat('dd MMM').format(rate.date),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
