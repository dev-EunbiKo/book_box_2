import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// shared_preferences를 사용한 데이터 저장소
/// - JSON 문자열 형태로 저장하는 것도 가능하지만, 값이 커질수록 앱 성능 저하 위험이 있음.
// / - int, double, bool, String, List<String>만 가능
/// - 보안이 필요한 데이터는 사용 금지!!
class StorageCore {
  static Future<void> setValue<T>(String key, T value) async {
    final prefs = await SharedPreferences.getInstance();

    if (value is String || value is int || value is double || value is bool) {
      await prefs.setString(key, value.toString());
    } else {
      final encodedValue = jsonEncode(value);
      await prefs.setString(key, encodedValue);
    }
  }

  static Future<T?> getValue<T>(
    String key, {
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final stringValue = prefs.getString(key);

    if (stringValue == null) return null;

    // value 타입에 따른 분기 처리
    switch (T) {
      case const (List<String>):
        List<String> decodedValue = List<String>.from(jsonDecode(stringValue));
        return decodedValue as T;
      case const (String):
        return stringValue as T;
      case const (int):
        return int.tryParse(stringValue) as T?;
      case const (double):
        return double.tryParse(stringValue) as T?;
      case const (bool):
        return (stringValue == 'true') as T?;
      default:
        if (fromJson != null) {
          final decodedValue = jsonDecode(stringValue);
          if (decodedValue is Map<String, dynamic>) {
            return fromJson(decodedValue);
          } else {
            return null;
          }
        } else {
          return null;
        }
    }
  }
}
