import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:krishi_connect/provider/farmer_provider.dart';
import 'package:krishi_connect/provider/gemini_provider.dart';
import 'package:krishi_connect/core/theme/theme_extenstion.dart';

class UserQueryScreen extends StatefulWidget {
  const UserQueryScreen({super.key});

  @override
  State<UserQueryScreen> createState() => _UserQueryScreenState();
}

class _UserQueryScreenState extends State<UserQueryScreen> {
  String? budget;
  int maxDuration = 6;
  int minIncome = 50000;
  String? season;

  final List<String> budgets = [
    "0-50000",
    "50000-100000",
    "100000-200000",
    "200000+",
  ];

  final Map<String, String> seasons = {
    "Kharif (June–October)": "Monsoon crops like soybean, cotton, rice",
    "Rabi (November–April)": "Winter crops like wheat, gram",
    "Zaid (March–June)": "Summer crops like watermelon, cucumber",
  };

  String _buildPrompt() {
    return '''
You are an expert agricultural planner for Maharashtra, India.

IMPORTANT RULES:
- DO NOT use markdown symbols (#, *, -, •)
- DO NOT mix English and Marathi in the same sentence
- First give English section
- Then give Marathi section
- Use clear headings exactly as written

FORMAT EXACTLY LIKE THIS:

ENGLISH:
Suitable Crops:
Estimated Budget Usage:
Expected Income Range:
Why These Crops Are Suitable:
Practical Tips:

MARATHI:
योग्य पिके:
अंदाजे खर्च:
अपेक्षित उत्पन्न:
ही पिके का योग्य आहेत:
उपयुक्त सूचना:

----------------------------------

Farmer inputs:
Budget range: ₹$budget
Maximum crop duration: $maxDuration months
Minimum expected income: ₹$minIncome
Season: $season

Conditions:
- Maharashtra soil and climate
- Market demand in Maharashtra mandis
- Suitable for small to medium farmers
- Focus on profit and risk reduction
''';
  }

  String cleanGeminiResponse(String raw) {
    return raw
        .replaceAll(RegExp(r'[#*•]+'), '')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
  }

  Map<String, String> parseResponse(String response) {
    final sections = <String, String>{};

    final english = RegExp(
      r'ENGLISH:(.*?)MARATHI:',
      dotAll: true,
    ).firstMatch(response);

    final marathi = RegExp(r'MARATHI:(.*)', dotAll: true).firstMatch(response);

    if (english != null) sections['english'] = english.group(1)!.trim();
    if (marathi != null) sections['marathi'] = marathi.group(1)!.trim();

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    final gemini = context.watch<GeminiProvider>();

    /// ✅ RESULT MODE
    if (gemini.response != null) {
      final cleaned = cleanGeminiResponse(gemini.response!);
      final sections = parseResponse(cleaned);

      return Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Crop Suggestions", style: context.textTheme.headlineSmall),
            10.verticalSpace,

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (sections['english'] != null) ...[
                      Text("English", style: context.textTheme.titleMedium),
                      8.verticalSpace,
                      Text(
                        sections['english']!,
                        style: context.textTheme.bodyLarge,
                      ),
                      20.verticalSpace,
                    ],
                    if (sections['marathi'] != null) ...[
                      Text("मराठी", style: context.textTheme.titleMedium),
                      8.verticalSpace,
                      Text(
                        sections['marathi']!,
                        style: context.textTheme.bodyLarge,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            16.verticalSpace,
            ElevatedButton.icon(
              onPressed: () => gemini.clear(),
              icon: const Icon(Icons.arrow_back),
              label: const Text("New Search"),
            ),
          ],
        ),
      );
    }

    /// ✅ INPUT MODE
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: ListView(
        children: [
          Text(
            "Crop Planning Assistant",
            style: context.textTheme.headlineSmall,
          ),
          30.verticalSpace,

          /// 💰 Budget
          DropdownButtonFormField<String>(
            value: budget,
            items: budgets
                .map((b) => DropdownMenuItem(value: b, child: Text("₹$b")))
                .toList(),
            onChanged: (v) => setState(() => budget = v),
            decoration: const InputDecoration(labelText: "Budget"),
          ),

          20.verticalSpace,

          /// ⏱️ Duration
          Text("Max Duration (months): $maxDuration"),
          Slider(
            value: maxDuration.toDouble(),
            min: 2,
            max: 12,
            divisions: 10,
            label: "$maxDuration",
            onChanged: (v) => setState(() => maxDuration = v.toInt()),
          ),

          20.verticalSpace,

          /// 💵 Income
          TextFormField(
            initialValue: minIncome.toString(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Min Expected Income (₹)",
            ),
            onChanged: (v) => minIncome = int.tryParse(v) ?? minIncome,
          ),

          20.verticalSpace,

          /// 🌦️ Season
          DropdownButtonFormField<String>(
            value: season,
            items: seasons.keys
                .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                .toList(),
            onChanged: (v) => setState(() => season = v),
            decoration: const InputDecoration(labelText: "Season"),
          ),

          30.verticalSpace,

          /// 🚀 Get Suggestions
          ElevatedButton(
            onPressed: gemini.loading || budget == null || season == null
                ? null
                : () async {
                    final prompt = _buildPrompt();
                    await context.read<GeminiProvider>().getAdvisory(prompt);
                  },
            child: gemini.loading
                ? const CircularProgressIndicator()
                : const Text("Get Crop Suggestions"),
          ),
        ],
      ),
    );
  }
}
