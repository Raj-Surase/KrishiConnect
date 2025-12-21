import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:krishi_connect/repo/api.dart';

class AuthProvider with ChangeNotifier {
  late ApiClient _apiClient;
  late AuthenticationApi _authApi;

  AuthProvider(ApiClient apiClient) {
    updateApiClient(apiClient);
  }

  void updateApiClient(ApiClient apiClient) {
    _apiClient = apiClient;
    _authApi = AuthenticationApi(_apiClient);
  }

  static const _tokenKey = 'auth_token';
  static const _roleKey = 'user_role';

  bool _loading = false;
  String? _error;
  Token? _token;
  User? _user;

  bool get loading => _loading;
  String? get error => _error;
  User? get user => _user;
  bool get isAuthenticated => _token != null;

  /// 🔐 LOGIN + CACHE TOKEN
  Future<void> login(String username, String password) async {
    _setLoading(true);
    try {
      _token = await _authApi.loginForAccessTokenApiV1AuthLoginPost(
        username,
        password,
      );

      if (_token == null || _token!.accessToken.isEmpty) {
        throw Exception("Invalid credentials");
      }

      /// Attach token to ApiClient
      _apiClient.addDefaultHeader(
        "Authorization",
        "Bearer ${_token!.accessToken}",
      );

      _user = await _authApi.readUsersMeApiV1AuthMeGet();

      /// Cache token + role
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_tokenKey, _token!.accessToken);
      await prefs.setString(_roleKey, _user!.role);

      _error = null;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  /// 🔄 RESTORE SESSION (USED IN SPLASH)
  Future<bool> restoreSession() async {
    _setLoading(true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenKey);

      if (token == null || token.isEmpty) {
        return false;
      }

      /// Attach cached token
      _apiClient.addDefaultHeader("Authorization", "Bearer $token");

      _token = Token(accessToken: token, tokenType: "bearer");

      /// Fetch user again (validates token)
      _user = await _authApi.readUsersMeApiV1AuthMeGet();

      return true;
    } catch (_) {
      await logout(); // token invalid
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// 🚪 LOGOUT (CLEAR CACHE)
  Future<void> logout() async {
    _token = null;
    _user = null;

    _apiClient.defaultHeaderMap.remove("Authorization");

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_roleKey);

    notifyListeners();
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
