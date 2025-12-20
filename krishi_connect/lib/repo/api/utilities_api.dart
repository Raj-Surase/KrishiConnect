//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UtilitiesApi {
  UtilitiesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create Or Update Api Key
  ///
  /// Create a new API key or update an existing one (Admin only).
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ApiKeyCreate] apiKeyCreate (required):
  Future<Response> createOrUpdateApiKeyApiV1UtilsKeysPostWithHttpInfo(ApiKeyCreate apiKeyCreate,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/utils/keys';

    // ignore: prefer_final_locals
    Object? postBody = apiKeyCreate;

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

  /// Create Or Update Api Key
  ///
  /// Create a new API key or update an existing one (Admin only).
  ///
  /// Parameters:
  ///
  /// * [ApiKeyCreate] apiKeyCreate (required):
  Future<ApiKey?> createOrUpdateApiKeyApiV1UtilsKeysPost(ApiKeyCreate apiKeyCreate,) async {
    final response = await createOrUpdateApiKeyApiV1UtilsKeysPostWithHttpInfo(apiKeyCreate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiKey',) as ApiKey;
    
    }
    return null;
  }

  /// Delete Api Key
  ///
  /// Delete an API key (Admin only).
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] serviceName (required):
  Future<Response> deleteApiKeyApiV1UtilsKeysServiceNameDeleteWithHttpInfo(String serviceName,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/utils/keys/{service_name}'
      .replaceAll('{service_name}', serviceName);

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

  /// Delete Api Key
  ///
  /// Delete an API key (Admin only).
  ///
  /// Parameters:
  ///
  /// * [String] serviceName (required):
  Future<void> deleteApiKeyApiV1UtilsKeysServiceNameDelete(String serviceName,) async {
    final response = await deleteApiKeyApiV1UtilsKeysServiceNameDeleteWithHttpInfo(serviceName,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// List Api Keys
  ///
  /// List all configured API keys (Admin only).
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> listApiKeysApiV1UtilsKeysGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/utils/keys';

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

  /// List Api Keys
  ///
  /// List all configured API keys (Admin only).
  Future<List<ApiKey>?> listApiKeysApiV1UtilsKeysGet() async {
    final response = await listApiKeysApiV1UtilsKeysGetWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<ApiKey>') as List)
        .cast<ApiKey>()
        .toList(growable: false);

    }
    return null;
  }

  /// Update Api Key
  ///
  /// Update an existing API key's value or status (Admin only).
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] serviceName (required):
  ///
  /// * [ApiKeyUpdate] apiKeyUpdate (required):
  Future<Response> updateApiKeyApiV1UtilsKeysServiceNamePutWithHttpInfo(String serviceName, ApiKeyUpdate apiKeyUpdate,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/utils/keys/{service_name}'
      .replaceAll('{service_name}', serviceName);

    // ignore: prefer_final_locals
    Object? postBody = apiKeyUpdate;

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

  /// Update Api Key
  ///
  /// Update an existing API key's value or status (Admin only).
  ///
  /// Parameters:
  ///
  /// * [String] serviceName (required):
  ///
  /// * [ApiKeyUpdate] apiKeyUpdate (required):
  Future<ApiKey?> updateApiKeyApiV1UtilsKeysServiceNamePut(String serviceName, ApiKeyUpdate apiKeyUpdate,) async {
    final response = await updateApiKeyApiV1UtilsKeysServiceNamePutWithHttpInfo(serviceName, apiKeyUpdate,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ApiKey',) as ApiKey;
    
    }
    return null;
  }
}
