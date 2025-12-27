import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiProvider with ChangeNotifier {
  static const _apiKey = "AIzaSyAq3L7HOGLgH3oW0bdQ4IWA5qnMS7j9ud4";

  final _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: _apiKey);

  bool _loading = false;
  String? _error;
  String? _cachedResponse;
  String? _lastPrompt;

  bool get loading => _loading;
  String? get error => _error;
  String? get response => _cachedResponse;

  Future<void> getAdvisory(String prompt) async {
    // ✅ Cache hit
    if (_lastPrompt == prompt && _cachedResponse != null) {
      return;
    }

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _model.generateContent([Content.text(prompt)]);

      _cachedResponse = result.text;
      _lastPrompt = prompt;
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  void clear() {
    _cachedResponse = null;
    _lastPrompt = null;
    notifyListeners();
  }
}
