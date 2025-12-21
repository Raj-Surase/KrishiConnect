import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'package:krishi_connect/core/custom_widgets/common_container.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';
import 'package:krishi_connect/provider/farmer_provider.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farmer = context.watch<FarmerProvider>();

    if (farmer.loading && farmer.crops.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (farmer.error != null) {
      return Center(child: Text(farmer.error!));
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Dashboard", style: context.textTheme.headlineSmall),
          20.verticalSpace,

          /// 📊 SUMMARY CARDS
          Row(
            children: [
              Expanded(
                child: _summaryCard(
                  context,
                  title: "Crops",
                  value: farmer.crops.length.toString(),
                  icon: Icons.agriculture_rounded,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: _summaryCard(
                  context,
                  title: "Schemes",
                  value: farmer.schemes.length.toString(),
                  icon: Icons.account_balance_rounded,
                ),
              ),
            ],
          ),
          12.verticalSpace,
          _summaryCard(
            context,
            title: "Market Rates",
            value: farmer.marketRates.length.toString(),
            icon: Icons.show_chart_rounded,
            fullWidth: true,
          ),

          20.verticalSpace,

          /// 📈 LATEST MARKET RATES
          _sectionTitle(context, "Latest Market Rates"),
          10.verticalSpace,

          if (farmer.marketRates.isEmpty)
            const Text("No market rates available")
          else
            Column(
              children: farmer.marketRates.take(3).map((rate) {
                final cropName = farmer.crops
                    .firstWhere(
                      (c) => c.id == rate.cropId,
                      orElse: () => farmer.crops.first,
                    )
                    .name;

                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: CommonContainer(
                    child: ListTile(
                      title: Text(cropName),
                      subtitle: Text(
                        "${rate.location} • ₹${rate.minPrice}-${rate.maxPrice} / ${rate.unit}",
                      ),
                      trailing: Text(DateFormat('dd MMM').format(rate.date)),
                    ),
                  ),
                );
              }).toList(),
            ),

          10.verticalSpace,

          /// 🏛️ GOVERNMENT SCHEMES
          _sectionTitle(context, "Government Schemes"),
          10.verticalSpace,

          if (farmer.schemes.isEmpty)
            const Text("No schemes available")
          else
            Column(
              children: farmer.schemes.take(3).map((scheme) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: CommonContainer(
                    child: ListTile(
                      leading: const Icon(Icons.account_balance),
                      title: Text(scheme.title),
                      subtitle: Text(
                        scheme.description ?? "No description available",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  /// ------------------------------
  /// 🧩 UI HELPERS
  /// ------------------------------

  Widget _summaryCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    bool fullWidth = false,
  }) {
    return CommonContainer(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Icon(icon, size: 30.sp, color: context.colorTheme.primary),
            12.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: context.textTheme.headlineSmall),
                Text(title, style: context.textTheme.bodyMedium),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Text(title, style: context.textTheme.titleMedium);
  }
}
