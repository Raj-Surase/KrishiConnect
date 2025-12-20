import 'package:flutter/foundation.dart';
import 'package:krishi_connect/repo/api.dart';

class AuthProvider with ChangeNotifier {
  final AuthenticationApi _authApi;

  AuthProvider(ApiClient apiClient) : _authApi = AuthenticationApi(apiClient);

  bool _loading = false;
  String? _error;
  Token? _token;
  User? _user;

  bool get loading => _loading;
  String? get error => _error;
  User? get user => _user;
  bool get isAuthenticated => _token != null;

  Future<void> login(String username, String password) async {
    _setLoading(true);
    try {
      _token = await _authApi.loginForAccessTokenApiV1AuthLoginPost(
        username,
        password,
      );
      if (_token == null) throw Exception("Invalid credentials");

      _user = await _authApi.readUsersMeApiV1AuthMeGet();
      _error = null;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> register(UserCreate user) async {
    _setLoading(true);
    try {
      await _authApi.registerUserApiV1AuthRegisterPost(user);
      _error = null;
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  void logout() {
    _token = null;
    _user = null;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
