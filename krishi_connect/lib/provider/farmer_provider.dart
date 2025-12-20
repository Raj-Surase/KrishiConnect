import 'package:flutter/foundation.dart';
import 'package:krishi_connect/repo/api.dart';

class FarmerProvider with ChangeNotifier {
  final FarmerApi _farmerApi;

  FarmerProvider(ApiClient apiClient) : _farmerApi = FarmerApi(apiClient);

  bool _loading = false;
  String? _error;

  bool get loading => _loading;
  String? get error => _error;

  List<Crop> crops = [];
  List<MarketRate> marketRates = [];
  List<GovernmentScheme> schemes = [];

  Future<void> loadCrops() async {
    crops = await _wrap(() => _farmerApi.listCropsApiV1FarmerCropsGet()) ?? [];
  }

  Future<void> loadMarketRates({int? cropId, String? location}) async {
    marketRates =
        await _wrap(
          () => _farmerApi.listMarketRatesApiV1FarmerMarketRatesGet(
            cropId: cropId,
            location: location,
          ),
        ) ??
        [];
  }

  Future<void> loadSchemes() async {
    schemes =
        await _wrap(() => _farmerApi.listSchemesApiV1FarmerSchemesGet()) ?? [];
  }

  Future<ChatbotResponse?> askChatbot(String message, String sessionId) {
    return _wrap(
      () => _farmerApi.chatbotQueryApiV1FarmerChatbotPost(
        ChatbotMessage(messageContent: message, sessionId: sessionId),
      ),
    );
  }

  Future<SoilAdvisoryResponse?> getSoilAdvisory(SoilAdvisoryRequest request) {
    return _wrap(
      () =>
          _farmerApi.getSoilAndCropAdvisoryApiV1FarmerAdvisorySoilPost(request),
    );
  }

  Future<T> _wrap<T>(Future<T> Function() action) async {
    _setLoading(true);
    try {
      _error = null;
      return await action();
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _setLoading(false);
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
