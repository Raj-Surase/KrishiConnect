//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatbotHistoryItem {
  /// Returns a new [ChatbotHistoryItem] instance.
  ChatbotHistoryItem({
    required this.sessionId,
    required this.messageType,
    required this.messageContent,
    required this.timestamp,
  });

  String sessionId;

  String messageType;

  String messageContent;

  DateTime timestamp;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatbotHistoryItem &&
    other.sessionId == sessionId &&
    other.messageType == messageType &&
    other.messageContent == messageContent &&
    other.timestamp == timestamp;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (sessionId.hashCode) +
    (messageType.hashCode) +
    (messageContent.hashCode) +
    (timestamp.hashCode);

  @override
  String toString() => 'ChatbotHistoryItem[sessionId=$sessionId, messageType=$messageType, messageContent=$messageContent, timestamp=$timestamp]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'session_id'] = this.sessionId;
      json[r'message_type'] = this.messageType;
      json[r'message_content'] = this.messageContent;
      json[r'timestamp'] = this.timestamp.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [ChatbotHistoryItem] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatbotHistoryItem? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatbotHistoryItem[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatbotHistoryItem[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatbotHistoryItem(
        sessionId: mapValueOfType<String>(json, r'session_id')!,
        messageType: mapValueOfType<String>(json, r'message_type')!,
        messageContent: mapValueOfType<String>(json, r'message_content')!,
        timestamp: mapDateTime(json, r'timestamp', r'')!,
      );
    }
    return null;
  }

  static List<ChatbotHistoryItem> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatbotHistoryItem>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatbotHistoryItem.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatbotHistoryItem> mapFromJson(dynamic json) {
    final map = <String, ChatbotHistoryItem>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatbotHistoryItem.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatbotHistoryItem-objects as value to a dart map
  static Map<String, List<ChatbotHistoryItem>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatbotHistoryItem>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatbotHistoryItem.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'session_id',
    'message_type',
    'message_content',
    'timestamp',
  };
}

