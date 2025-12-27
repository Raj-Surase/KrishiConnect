import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:krishi_connect/provider/farmer_provider.dart';
import 'package:krishi_connect/provider/gemini_provider.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';

class UserQueryScreen extends StatelessWidget {
  const UserQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: context.colorTheme.surface,
            child: TabBar(
              tabs: [
                Tab(text: "Crop Planning"),
                Tab(text: "Crop Advisory"),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [_CropPlanningTab(), _CropAdvisoryTab()],
            ),
          ),
        ],
      ),
    );
  }
}

class _CropPlanningTab extends StatefulWidget {
  const _CropPlanningTab();

  @override
  State<_CropPlanningTab> createState() => _CropPlanningTabState();
}

class _CropPlanningTabState extends State<_CropPlanningTab> {
  String? budget;
  int duration = 6;
  int income = 50000;
  String? season;

  final budgets = ["0-50000", "50000-100000", "100000-200000", "200000+"];

  final seasons = ["Kharif", "Rabi", "Zaid"];

  String _prompt() {
    return '''
Suggest crops for Maharashtra.

Inputs:
Budget: ₹$budget
Duration: $duration months
Min income: ₹$income
Season: $season

Output format:
ENGLISH:
Crops:
Why:
Tips:

MARATHI:
पिके:
कारण:
सूचना:
''';
  }

  @override
  Widget build(BuildContext context) {
    final gemini = context.watch<GeminiProvider>();

    if (gemini.error != null) {
      return Center(
        child: Text(gemini.error!, style: const TextStyle(color: Colors.red)),
      );
    }

    if (gemini.hasResponse(GeminiScope.cropPlanning)) {
      return _ResultView(
        text: gemini.responseFor(GeminiScope.cropPlanning)!,
        onBack: () => gemini.clear(GeminiScope.cropPlanning),
      );
    }

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: ListView(
        children: [
          Text(
            "Crop Planning Assistant",
            style: context.textTheme.headlineSmall,
          ),
          30.verticalSpace,

          DropdownButtonFormField<String>(
            value: budget,
            items: budgets
                .map((b) => DropdownMenuItem(value: b, child: Text("₹$b")))
                .toList(),
            onChanged: (v) => setState(() => budget = v),
            decoration: const InputDecoration(labelText: "Budget"),
          ),

          20.verticalSpace,

          Text("Max Duration: $duration months"),
          Slider(
            value: duration.toDouble(),
            min: 2,
            max: 12,
            divisions: 10,
            onChanged: (v) => setState(() => duration = v.toInt()),
          ),

          20.verticalSpace,

          TextFormField(
            initialValue: income.toString(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Min Expected Income (₹)",
            ),
            onChanged: (v) => income = int.tryParse(v) ?? income,
          ),

          20.verticalSpace,

          DropdownButtonFormField<String>(
            value: season,
            items: seasons
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (v) => setState(() => season = v),
            decoration: const InputDecoration(labelText: "Season"),
          ),

          30.verticalSpace,

          ElevatedButton(
            onPressed: gemini.loading || budget == null || season == null
                ? null
                : () => gemini.getAdvisory(
                    scope: GeminiScope.cropPlanning,
                    prompt: _prompt(),
                  ),

            child: gemini.loading
                ? const CircularProgressIndicator()
                : const Text("Get Suggestions"),
          ),
        ],
      ),
    );
  }
}

class _CropAdvisoryTab extends StatefulWidget {
  const _CropAdvisoryTab();

  @override
  State<_CropAdvisoryTab> createState() => _CropAdvisoryTabState();
}

class _CropAdvisoryTabState extends State<_CropAdvisoryTab> {
  int? cropId;
  double fertility = 50;

  String _prompt(FarmerProvider farmer) {
    final crop = farmer.crops.firstWhere((c) => c.id == cropId);

    return '''
Crop: ${crop.name}
Fertility: ${fertility.toInt()}%

Give advice.

Format:
ENGLISH:
Advice:
Tips:

MARATHI:
सल्ला:
सूचना:
''';
  }

  @override
  Widget build(BuildContext context) {
    final farmer = context.watch<FarmerProvider>();
    final gemini = context.watch<GeminiProvider>();

    if (gemini.error != null) {
      return Center(
        child: Text(gemini.error!, style: const TextStyle(color: Colors.red)),
      );
    }

    if (gemini.hasResponse(GeminiScope.cropAdvisory)) {
      return _ResultView(
        text: gemini.responseFor(GeminiScope.cropAdvisory)!,
        onBack: () => gemini.clear(GeminiScope.cropAdvisory),
      );
    }

    return Padding(
      padding: EdgeInsets.all(20.w),
      child: ListView(
        children: [
          Text("Crop Advisory", style: context.textTheme.headlineSmall),
          30.verticalSpace,

          DropdownButtonFormField<int>(
            value: cropId,
            items: farmer.crops
                .map((c) => DropdownMenuItem(value: c.id, child: Text(c.name)))
                .toList(),
            onChanged: (v) => setState(() => cropId = v),
            decoration: const InputDecoration(labelText: "Select Crop"),
          ),

          30.verticalSpace,

          Text("Soil Fertility: ${fertility.toInt()}%"),
          Slider(
            value: fertility,
            min: 0,
            max: 100,
            divisions: 10,
            onChanged: (v) => setState(() => fertility = v),
          ),

          30.verticalSpace,

          ElevatedButton(
            onPressed: gemini.loading || cropId == null
                ? null
                : () => gemini.getAdvisory(
                    scope: GeminiScope.cropAdvisory,
                    prompt: _prompt(farmer),
                  ),

            child: gemini.loading
                ? const CircularProgressIndicator()
                : const Text("Get Advisory"),
          ),
        ],
      ),
    );
  }
}

class _ResultView extends StatelessWidget {
  final String text;
  final VoidCallback onBack;

  const _ResultView({required this.text, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("AI Result", style: context.textTheme.headlineSmall),
          10.verticalSpace,
          Expanded(
            child: SingleChildScrollView(
              child: Text(text, style: context.textTheme.bodyLarge),
            ),
          ),
          16.verticalSpace,
          ElevatedButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
            label: const Text("New Query"),
          ),
        ],
      ),
    );
  }
}
