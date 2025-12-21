import 'package:flutter/foundation.dart';
import 'package:krishi_connect/repo/api.dart';

class AdminProvider with ChangeNotifier {
  late AdminApi _adminApi;

  AdminProvider(ApiClient apiClient) {
    updateApiClient(apiClient);
  }

  void updateApiClient(ApiClient apiClient) {
    _adminApi = AdminApi(apiClient);
  }

  bool _loading = false;
  String? _error;

  bool get loading => _loading;
  String? get error => _error;

  Future<Crop?> createCrop(CropCreate data) async {
    return _wrap(() => _adminApi.createNewCropApiV1AdminCropsPost(data));
  }

  Future<Crop?> updateCrop(int id, CropUpdate data) async {
    return _wrap(
      () => _adminApi.updateExistingCropApiV1AdminCropsCropIdPut(id, data),
    );
  }

  Future<void> deleteCrop(int id) async {
    await _wrap(() => _adminApi.deleteCropApiV1AdminCropsCropIdDelete(id));
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
    }
  }

  void _setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }
}
