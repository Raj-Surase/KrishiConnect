import 'package:flutter/foundation.dart';
import 'package:krishi_connect/repo/api.dart';

class ApiProvider with ChangeNotifier {
  late ApiClient _apiClient;

  late AuthenticationApi authApi;
  late FarmerApi farmerApi;
  late AdminApi adminApi;
  late UtilitiesApi utilitiesApi;

  String? _token;

  ApiProvider(ApiClient apiClient) {
    updateApiClient(apiClient);
  }

  void updateApiClient(ApiClient apiClient) {
    _apiClient = apiClient;

    authApi = AuthenticationApi(_apiClient);
    farmerApi = FarmerApi(_apiClient);
    adminApi = AdminApi(_apiClient);
    utilitiesApi = UtilitiesApi(_apiClient);
  }

  void setToken(String token) {
    _token = token;
    _apiClient.addDefaultHeader("Authorization", "Bearer $token");
    notifyListeners();
  }

  void clearToken() {
    _token = null;
    _apiClient.defaultHeaderMap.remove("Authorization");
    notifyListeners();
  }

  bool get isAuthenticated => _token != null;
}
