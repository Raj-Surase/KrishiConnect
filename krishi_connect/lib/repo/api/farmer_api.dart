//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class FarmerApi {
  FarmerApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Chatbot Query
  ///
  /// Send a message to the AI Chatbot and get a response with updated history.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ChatbotMessage] chatbotMessage (required):
  Future<Response> chatbotQueryApiV1FarmerChatbotPostWithHttpInfo(ChatbotMessage chatbotMessage,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/farmer/chatbot';

    // ignore: prefer_final_locals
    Object? postBody = chatbotMessage;

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

  /// Chatbot Query
  ///
  /// Send a message to the AI Chatbot and get a response with updated history.
  ///
  /// Parameters:
  ///
  /// * [ChatbotMessage] chatbotMessage (required):
  Future<ChatbotResponse?> chatbotQueryApiV1FarmerChatbotPost(ChatbotMessage chatbotMessage,) async {
    final response = await chatbotQueryApiV1FarmerChatbotPostWithHttpInfo(chatbotMessage,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ChatbotResponse',) as ChatbotResponse;
    
    }
    return null;
  }

  /// Farmer Status
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> farmerStatusApiV1FarmerStatusGetWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/farmer/status';

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

  /// Farmer Status
  Future<Object?> farmerStatusApiV1FarmerStatusGet() async {
    final response = await farmerStatusApiV1FarmerStatusGetWithHttpInfo();
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

  /// Get Soil And Crop Advisory
  ///
  /// Get AI-powered soil and crop advisory based on farmer input.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SoilAdvisoryRequest] soilAdvisoryRequest (required):
  Future<Response> getSoilAndCropAdvisoryApiV1FarmerAdvisorySoilPostWithHttpInfo(SoilAdvisoryRequest soilAdvisoryRequest,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/farmer/advisory/soil';

    // ignore: prefer_final_locals
    Object? postBody = soilAdvisoryRequest;

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

  /// Get Soil And Crop Advisory
  ///
  /// Get AI-powered soil and crop advisory based on farmer input.
  ///
  /// Parameters:
  ///
  /// * [SoilAdvisoryRequest] soilAdvisoryRequest (required):
  Future<SoilAdvisoryResponse?> getSoilAndCropAdvisoryApiV1FarmerAdvisorySoilPost(SoilAdvisoryRequest soilAdvisoryRequest,) async {
    final response = await getSoilAndCropAdvisoryApiV1FarmerAdvisorySoilPostWithHttpInfo(soilAdvisoryRequest,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SoilAdvisoryResponse',) as SoilAdvisoryResponse;
    
    }
    return null;
  }

  /// List Crops
  ///
  /// List all available crops for advisory and market rates.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] skip:
  ///
  /// * [int] limit:
  Future<Response> listCropsApiV1FarmerCropsGetWithHttpInfo({ int? skip, int? limit, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/farmer/crops';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (skip != null) {
      queryParams.addAll(_queryParams('', 'skip', skip));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }

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

  /// List Crops
  ///
  /// List all available crops for advisory and market rates.
  ///
  /// Parameters:
  ///
  /// * [int] skip:
  ///
  /// * [int] limit:
  Future<List<Crop>?> listCropsApiV1FarmerCropsGet({ int? skip, int? limit, }) async {
    final response = await listCropsApiV1FarmerCropsGetWithHttpInfo( skip: skip, limit: limit, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<Crop>') as List)
        .cast<Crop>()
        .toList(growable: false);

    }
    return null;
  }

  /// List Market Rates
  ///
  /// List daily market rates, with optional filters.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] cropId:
  ///
  /// * [String] location:
  ///
  /// * [String] date:
  ///
  /// * [int] skip:
  ///
  /// * [int] limit:
  Future<Response> listMarketRatesApiV1FarmerMarketRatesGetWithHttpInfo({ int? cropId, String? location, String? date, int? skip, int? limit, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/farmer/market_rates';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (cropId != null) {
      queryParams.addAll(_queryParams('', 'crop_id', cropId));
    }
    if (location != null) {
      queryParams.addAll(_queryParams('', 'location', location));
    }
    if (date != null) {
      queryParams.addAll(_queryParams('', 'date', date));
    }
    if (skip != null) {
      queryParams.addAll(_queryParams('', 'skip', skip));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }

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

  /// List Market Rates
  ///
  /// List daily market rates, with optional filters.
  ///
  /// Parameters:
  ///
  /// * [int] cropId:
  ///
  /// * [String] location:
  ///
  /// * [String] date:
  ///
  /// * [int] skip:
  ///
  /// * [int] limit:
  Future<List<MarketRate>?> listMarketRatesApiV1FarmerMarketRatesGet({ int? cropId, String? location, String? date, int? skip, int? limit, }) async {
    final response = await listMarketRatesApiV1FarmerMarketRatesGetWithHttpInfo( cropId: cropId, location: location, date: date, skip: skip, limit: limit, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<MarketRate>') as List)
        .cast<MarketRate>()
        .toList(growable: false);

    }
    return null;
  }

  /// List Schemes
  ///
  /// List all government schemes.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] skip:
  ///
  /// * [int] limit:
  Future<Response> listSchemesApiV1FarmerSchemesGetWithHttpInfo({ int? skip, int? limit, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/farmer/schemes';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (skip != null) {
      queryParams.addAll(_queryParams('', 'skip', skip));
    }
    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }

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

  /// List Schemes
  ///
  /// List all government schemes.
  ///
  /// Parameters:
  ///
  /// * [int] skip:
  ///
  /// * [int] limit:
  Future<List<GovernmentScheme>?> listSchemesApiV1FarmerSchemesGet({ int? skip, int? limit, }) async {
    final response = await listSchemesApiV1FarmerSchemesGetWithHttpInfo( skip: skip, limit: limit, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<GovernmentScheme>') as List)
        .cast<GovernmentScheme>()
        .toList(growable: false);

    }
    return null;
  }
}
