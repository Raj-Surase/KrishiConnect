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
    final _formKey = GlobalKey<FormState>();

    int? cropId;
    DateTime? selectedDate;

    final locationCtrl = TextEditingController();
    final minPriceCtrl = TextEditingController();
    final maxPriceCtrl = TextEditingController();
    final expectedPriceCtrl = TextEditingController();
    final dateCtrl = TextEditingController();

    num? _minPrice() => num.tryParse(minPriceCtrl.text);
    num? _maxPrice() => num.tryParse(maxPriceCtrl.text);
    num? _expectedPrice() => num.tryParse(expectedPriceCtrl.text);

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
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r)),
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
                child: Form(
                  key: _formKey,
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
                        validator: (v) =>
                            v == null ? "Please select a crop" : null,
                        decoration: const InputDecoration(labelText: "Crop"),
                      ),
                      20.verticalSpace,

                      /// Location
                      TextFormField(
                        controller: locationCtrl,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Location is required";
                          }
                          if (value.length < 2) {
                            return "Location must be at least 2 characters";
                          }
                          if (!RegExp(r'^\d').hasMatch(value.trim())) {
                            return "Location must start with a number";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Location",
                        ),
                      ),
                      20.verticalSpace,

                      /// Date
                      TextFormField(
                        controller: dateCtrl,
                        readOnly: true,
                        onTap: () => _pickDate(context),
                        validator: (_) => selectedDate == null
                            ? "Please select a date"
                            : null,
                        decoration: const InputDecoration(
                          labelText: "Date",
                          suffixIcon: Icon(Icons.calendar_today),
                        ),
                      ),
                      20.verticalSpace,

                      /// Min Price
                      TextFormField(
                        controller: minPriceCtrl,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final min = _minPrice();
                          final max = _maxPrice();

                          if (value == null || value.isEmpty) {
                            return "Min price is required";
                          }
                          if (min == null) {
                            return "Min price must be a number";
                          }
                          if (max != null && min >= max) {
                            return "Min price must be less than max price";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Min Price",
                        ),
                      ),
                      20.verticalSpace,

                      /// Max Price
                      TextFormField(
                        controller: maxPriceCtrl,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final min = _minPrice();
                          final max = _maxPrice();

                          if (value == null || value.isEmpty) {
                            return "Max price is required";
                          }
                          if (max == null) {
                            return "Max price must be a number";
                          }
                          if (min != null && max <= min) {
                            return "Max price must be greater than min price";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Max Price",
                        ),
                      ),
                      20.verticalSpace,

                      /// Expected Price
                      TextFormField(
                        controller: expectedPriceCtrl,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) return null;

                          final exp = _expectedPrice();
                          final min = _minPrice();
                          final max = _maxPrice();

                          if (exp == null) {
                            return "Expected price must be a number";
                          }
                          if (min != null && exp <= min) {
                            return "Expected price must be greater than min price";
                          }
                          if (max != null && exp >= max) {
                            return "Expected price must be less than max price";
                          }
                          return null;
                        },
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
                            if (!_formKey.currentState!.validate()) return;

                            await context
                                .read<AdminProvider>()
                                .createMarketRate(
                                  MarketRateCreate(
                                    cropId: cropId!,
                                    location: locationCtrl.text.trim(),
                                    date: selectedDate!,
                                    minPrice: _minPrice()!,
                                    maxPrice: _maxPrice()!,
                                    expectedPrice:
                                        expectedPriceCtrl.text.isEmpty
                                        ? null
                                        : _expectedPrice(),
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
      ),
    );
  }
}
