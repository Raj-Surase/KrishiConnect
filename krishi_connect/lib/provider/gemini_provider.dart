import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

enum GeminiScope { cropPlanning, cropAdvisory }

class GeminiProvider with ChangeNotifier {
  static const _apiKey = "AIzaSyAdKVSzouN8aH0RuAmnmoXwmRyT6EZd-_c";

  final _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: _apiKey);

  bool _loading = false;
  String? _error;

  GeminiScope? _activeScope;
  final Map<GeminiScope, String> _responses = {};

  bool get loading => _loading;
  String? get error => _error;

  String? responseFor(GeminiScope scope) => _responses[scope];

  bool hasResponse(GeminiScope scope) => _responses.containsKey(scope);

  Future<void> getAdvisory({
    required GeminiScope scope,
    required String prompt,
  }) async {
    _loading = true;
    _error = null;
    _activeScope = scope;
    notifyListeners();

    try {
      final result = await _model.generateContent([Content.text(prompt)]);

      final text = result.candidates
          .expand((c) => c.content.parts)
          .whereType<TextPart>()
          .map((p) => p.text)
          .join("\n")
          .trim();

      if (text.isEmpty) {
        throw Exception("No AI response generated");
      }

      _responses[scope] = text;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void clear(GeminiScope scope) {
    _responses.remove(scope);
    _error = null;
    notifyListeners();
  }
}
