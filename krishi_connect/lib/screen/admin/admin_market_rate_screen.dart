import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:krishi_connect/core/custom_widgets/common_container.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:krishi_connect/provider/farmer_provider.dart';
import 'package:krishi_connect/provider/admin_provider.dart';
import 'package:krishi_connect/repo/api.dart';

class AdminMarketRateScreen extends StatelessWidget {
  const AdminMarketRateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final farmer = context.watch<FarmerProvider>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openMarketRateForm(context),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: farmer.marketRates.length,
        itemBuilder: (_, i) {
          final rate = farmer.marketRates[i];
          final cropName = farmer.crops
              .firstWhere((c) => c.id == rate.cropId)
              .name;

          return Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: CommonContainer(
              child: ListTile(
                title: Text(cropName),
                subtitle: Text(
                  "${rate.location} \n₹${rate.minPrice}-${rate.maxPrice} / ${rate.unit}",
                ),
                trailing: Text(DateFormat('dd MMM').format(rate.date)),
              ),
            ),
          );
        },
      ),
    );
  }

  void _openMarketRateForm(BuildContext context) {
    final farmer = context.read<FarmerProvider>();

    int? cropId;
    DateTime? selectedDate;

    final location = TextEditingController();
    final minPrice = TextEditingController();
    final maxPrice = TextEditingController();
    final expectedPrice = TextEditingController();
    final dateCtrl = TextEditingController();

    Future<void> _pickDate(BuildContext context) async {
      final now = DateTime.now();

      final picked = await showDatePicker(
        context: context,
        initialDate: selectedDate ?? now,
        firstDate: DateTime(now.year - 1),
        lastDate: DateTime(now.year + 1),
      );

      if (picked != null) {
        selectedDate = picked;
        dateCtrl.text = DateFormat('yyyy-MM-dd').format(picked);
      }
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.vertical(
            top: Radius.circular(40.r),
          ),
          child: Container(
            color: context.colorTheme.surface,
            child: Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    10.verticalSpace,
                    Text(
                      "Add Market Rate",
                      style: context.textTheme.titleLarge,
                    ),
                    30.verticalSpace,

                    /// Crop
                    DropdownButtonFormField<int>(
                      items: farmer.crops
                          .map(
                            (c) => DropdownMenuItem(
                              value: c.id,
                              child: Text(c.name),
                            ),
                          )
                          .toList(),
                      onChanged: (v) => cropId = v,
                      decoration: const InputDecoration(labelText: "Crop"),
                    ),
                    20.verticalSpace,

                    /// Location
                    TextField(
                      controller: location,
                      decoration: const InputDecoration(labelText: "Location"),
                    ),
                    20.verticalSpace,

                    /// Date Picker
                    TextField(
                      controller: dateCtrl,
                      readOnly: true,
                      onTap: () => _pickDate(context),
                      decoration: const InputDecoration(
                        labelText: "Date",
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                    ),
                    20.verticalSpace,

                    /// Prices
                    TextField(
                      controller: minPrice,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Min Price"),
                    ),
                    20.verticalSpace,
                    TextField(
                      controller: maxPrice,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Max Price"),
                    ),
                    20.verticalSpace,
                    TextField(
                      controller: expectedPrice,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Expected Price",
                      ),
                    ),
                    30.verticalSpace,

                    /// Save
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (cropId == null || selectedDate == null) return;

                          await context.read<AdminProvider>().createMarketRate(
                            MarketRateCreate(
                              cropId: cropId!,
                              location: location.text,
                              date: selectedDate!,
                              minPrice: num.parse(minPrice.text),
                              maxPrice: num.parse(maxPrice.text),
                              expectedPrice: expectedPrice.text.isEmpty
                                  ? null
                                  : num.parse(expectedPrice.text),
                            ),
                          );

                          await farmer.loadMarketRates();
                          Navigator.pop(context);
                        },
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
