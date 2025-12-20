//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ChatbotMessage {
  /// Returns a new [ChatbotMessage] instance.
  ChatbotMessage({
    required this.sessionId,
    required this.messageContent,
  });

  String sessionId;

  String messageContent;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ChatbotMessage &&
    other.sessionId == sessionId &&
    other.messageContent == messageContent;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (sessionId.hashCode) +
    (messageContent.hashCode);

  @override
  String toString() => 'ChatbotMessage[sessionId=$sessionId, messageContent=$messageContent]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'session_id'] = this.sessionId;
      json[r'message_content'] = this.messageContent;
    return json;
  }

  /// Returns a new [ChatbotMessage] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ChatbotMessage? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ChatbotMessage[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ChatbotMessage[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ChatbotMessage(
        sessionId: mapValueOfType<String>(json, r'session_id')!,
        messageContent: mapValueOfType<String>(json, r'message_content')!,
      );
    }
    return null;
  }

  static List<ChatbotMessage> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ChatbotMessage>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ChatbotMessage.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ChatbotMessage> mapFromJson(dynamic json) {
    final map = <String, ChatbotMessage>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ChatbotMessage.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ChatbotMessage-objects as value to a dart map
  static Map<String, List<ChatbotMessage>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ChatbotMessage>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ChatbotMessage.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'session_id',
    'message_content',
  };
}

