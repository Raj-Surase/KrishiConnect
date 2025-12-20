//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/admin_api.dart';
part 'api/authentication_api.dart';
part 'api/default_api.dart';
part 'api/farmer_api.dart';
part 'api/utilities_api.dart';

part 'model/api_key.dart';
part 'model/api_key_create.dart';
part 'model/api_key_update.dart';
part 'model/chatbot_history_item.dart';
part 'model/chatbot_message.dart';
part 'model/chatbot_response.dart';
part 'model/crop.dart';
part 'model/crop_create.dart';
part 'model/crop_update.dart';
part 'model/government_scheme.dart';
part 'model/government_scheme_create.dart';
part 'model/government_scheme_update.dart';
part 'model/http_validation_error.dart';
part 'model/market_rate.dart';
part 'model/market_rate_create.dart';
part 'model/market_rate_update.dart';
part 'model/soil_advisory_request.dart';
part 'model/soil_advisory_response.dart';
part 'model/token.dart';
part 'model/user.dart';
part 'model/user_create.dart';
part 'model/validation_error.dart';
part 'model/validation_error_loc_inner.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
