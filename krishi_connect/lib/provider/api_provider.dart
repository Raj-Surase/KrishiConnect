import 'package:flutter/foundation.dart';
import 'package:krishi_connect/repo/api.dart';

class ApiProvider with ChangeNotifier {
  final ApiClient apiClient;

  late AuthenticationApi authApi;
  late FarmerApi farmerApi;
  late AdminApi adminApi;
  late UtilitiesApi utilitiesApi;

  String? _token;

  ApiProvider(this.apiClient) {
    _initApis();
  }

  void _initApis() {
    authApi = AuthenticationApi(apiClient);
    farmerApi = FarmerApi(apiClient);
    adminApi = AdminApi(apiClient);
    utilitiesApi = UtilitiesApi(apiClient);
  }

  void setToken(String token) {
    _token = token;
    apiClient.addDefaultHeader("Authorization", "Bearer $token");
    notifyListeners();
  }

  void clearToken() {
    _token = null;
    apiClient.defaultHeaderMap.remove("Authorization");
    notifyListeners();
  }

  bool get isAuthenticated => _token != null;
}
