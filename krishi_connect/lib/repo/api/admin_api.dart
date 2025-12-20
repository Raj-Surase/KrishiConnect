//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AdminApi {
  AdminApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Admin Status
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> adminStatusApiV1AdminStatusGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/admin/status';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Admin Status
  Future<Object?> adminStatusApiV1AdminStatusGet() async {
    final response = await adminStatusApiV1AdminStatusGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Object',) as Object;
    
    }
    return null;
  }

  /// Create New Crop
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [CropCreate] cropCreate (required):
  Future<Response> createNewCropApiV1AdminCropsPostWithHttpInfo(CropCreate cropCreate,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/admin/crops';

    // ignore: prefer_final_locals
    Object? postBody = cropCreate;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Create New Crop
  ///
  /// Parameters:
  ///
  /// * [CropCreate] cropCreate (required):
  Future<Crop?> createNewCropApiV1AdminCropsPost(CropCreate cropCreate,) async {
    final response = await createNewCropApiV1AdminCropsPostWithHttpInfo(cropCreate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Crop',) as Crop;
    
    }
    return null;
  }

  /// Create New Market Rate
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MarketRateCreate] marketRateCreate (required):
  Future<Response> createNewMarketRateApiV1AdminMarketRatesPostWithHttpInfo(MarketRateCreate marketRateCreate,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/admin/market_rates';

    // ignore: prefer_final_locals
    Object? postBody = marketRateCreate;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Create New Market Rate
  ///
  /// Parameters:
  ///
  /// * [MarketRateCreate] marketRateCreate (required):
  Future<MarketRate?> createNewMarketRateApiV1AdminMarketRatesPost(MarketRateCreate marketRateCreate,) async {
    final response = await createNewMarketRateApiV1AdminMarketRatesPostWithHttpInfo(marketRateCreate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MarketRate',) as MarketRate;
    
    }
    return null;
  }

  /// Create New Scheme
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GovernmentSchemeCreate] governmentSchemeCreate (required):
  Future<Response> createNewSchemeApiV1AdminSchemesPostWithHttpInfo(GovernmentSchemeCreate governmentSchemeCreate,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/admin/schemes';

    // ignore: prefer_final_locals
    Object? postBody = governmentSchemeCreate;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Create New Scheme
  ///
  /// Parameters:
  ///
  /// * [GovernmentSchemeCreate] governmentSchemeCreate (required):
  Future<GovernmentScheme?> createNewSchemeApiV1AdminSchemesPost(GovernmentSchemeCreate governmentSchemeCreate,) async {
    final response = await createNewSchemeApiV1AdminSchemesPostWithHttpInfo(governmentSchemeCreate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GovernmentScheme',) as GovernmentScheme;
    
    }
    return null;
  }

  /// Delete Crop
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] cropId (required):
  Future<Response> deleteCropApiV1AdminCropsCropIdDeleteWithHttpInfo(int cropId,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/admin/crops/{crop_id}'
      .replaceAll('{crop_id}', cropId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete Crop
  ///
  /// Parameters:
  ///
  /// * [int] cropId (required):
  Future<void> deleteCropApiV1AdminCropsCropIdDelete(int cropId,) async {
    final response = await deleteCropApiV1AdminCropsCropIdDeleteWithHttpInfo(cropId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Delete Market Rate
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] rateId (required):
  Future<Response> deleteMarketRateApiV1AdminMarketRatesRateIdDeleteWithHttpInfo(int rateId,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/admin/market_rates/{rate_id}'
      .replaceAll('{rate_id}', rateId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete Market Rate
  ///
  /// Parameters:
  ///
  /// * [int] rateId (required):
  Future<void> deleteMarketRateApiV1AdminMarketRatesRateIdDelete(int rateId,) async {
    final response = await deleteMarketRateApiV1AdminMarketRatesRateIdDeleteWithHttpInfo(rateId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Delete Scheme
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] schemeId (required):
  Future<Response> deleteSchemeApiV1AdminSchemesSchemeIdDeleteWithHttpInfo(int schemeId,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/admin/schemes/{scheme_id}'
      .replaceAll('{scheme_id}', schemeId.toString());

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete Scheme
  ///
  /// Parameters:
  ///
  /// * [int] schemeId (required):
  Future<void> deleteSchemeApiV1AdminSchemesSchemeIdDelete(int schemeId,) async {
    final response = await deleteSchemeApiV1AdminSchemesSchemeIdDeleteWithHttpInfo(schemeId,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Update Existing Crop
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] cropId (required):
  ///
  /// * [CropUpdate] cropUpdate (required):
  Future<Response> updateExistingCropApiV1AdminCropsCropIdPutWithHttpInfo(int cropId, CropUpdate cropUpdate,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/admin/crops/{crop_id}'
      .replaceAll('{crop_id}', cropId.toString());

    // ignore: prefer_final_locals
    Object? postBody = cropUpdate;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update Existing Crop
  ///
  /// Parameters:
  ///
  /// * [int] cropId (required):
  ///
  /// * [CropUpdate] cropUpdate (required):
  Future<Crop?> updateExistingCropApiV1AdminCropsCropIdPut(int cropId, CropUpdate cropUpdate,) async {
    final response = await updateExistingCropApiV1AdminCropsCropIdPutWithHttpInfo(cropId, cropUpdate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Crop',) as Crop;
    
    }
    return null;
  }

  /// Update Existing Market Rate
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] rateId (required):
  ///
  /// * [MarketRateUpdate] marketRateUpdate (required):
  Future<Response> updateExistingMarketRateApiV1AdminMarketRatesRateIdPutWithHttpInfo(int rateId, MarketRateUpdate marketRateUpdate,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/admin/market_rates/{rate_id}'
      .replaceAll('{rate_id}', rateId.toString());

    // ignore: prefer_final_locals
    Object? postBody = marketRateUpdate;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update Existing Market Rate
  ///
  /// Parameters:
  ///
  /// * [int] rateId (required):
  ///
  /// * [MarketRateUpdate] marketRateUpdate (required):
  Future<MarketRate?> updateExistingMarketRateApiV1AdminMarketRatesRateIdPut(int rateId, MarketRateUpdate marketRateUpdate,) async {
    final response = await updateExistingMarketRateApiV1AdminMarketRatesRateIdPutWithHttpInfo(rateId, marketRateUpdate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'MarketRate',) as MarketRate;
    
    }
    return null;
  }

  /// Update Existing Scheme
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] schemeId (required):
  ///
  /// * [GovernmentSchemeUpdate] governmentSchemeUpdate (required):
  Future<Response> updateExistingSchemeApiV1AdminSchemesSchemeIdPutWithHttpInfo(int schemeId, GovernmentSchemeUpdate governmentSchemeUpdate,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/admin/schemes/{scheme_id}'
      .replaceAll('{scheme_id}', schemeId.toString());

    // ignore: prefer_final_locals
    Object? postBody = governmentSchemeUpdate;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Update Existing Scheme
  ///
  /// Parameters:
  ///
  /// * [int] schemeId (required):
  ///
  /// * [GovernmentSchemeUpdate] governmentSchemeUpdate (required):
  Future<GovernmentScheme?> updateExistingSchemeApiV1AdminSchemesSchemeIdPut(int schemeId, GovernmentSchemeUpdate governmentSchemeUpdate,) async {
    final response = await updateExistingSchemeApiV1AdminSchemesSchemeIdPutWithHttpInfo(schemeId, governmentSchemeUpdate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GovernmentScheme',) as GovernmentScheme;
    
    }
    return null;
  }
}
