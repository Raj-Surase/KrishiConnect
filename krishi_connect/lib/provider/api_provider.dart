import 'package:flutter/foundation.dart';
import 'package:krishi_connect/repo/api.dart';

class ApiProvider with ChangeNotifier {
  late ApiClient _apiClient;

  late AuthenticationApi authApi;
  late FarmerApi farmerApi;
  late AdminApi adminApi;
  late UtilitiesApi utilitiesApi;

  String? _token;

  ApiProvider() {
    _apiClient = ApiClient(
      basePath: "http://localhost:8000", // 🔴 CHANGE THIS
    );

    _initApis();
  }

  void _initApis() {
    authApi = AuthenticationApi(_apiClient);
    farmerApi = FarmerApi(_apiClient);
    adminApi = AdminApi(_apiClient);
    utilitiesApi = UtilitiesApi(_apiClient);
  }

  /// 🔐 Set JWT token after login
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
