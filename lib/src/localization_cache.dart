import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'delivery_api.dart';

class CachedBundle {
  const CachedBundle({required this.data, this.etag, this.releaseId});
  final Map<String, dynamic> data;
  final String? etag;
  final String? releaseId;
}

class LocalizationCache {
  LocalizationCache({SharedPreferences? preferences})
      : _preferences = preferences;

  SharedPreferences? _preferences;

  Future<SharedPreferences> get _store async =>
      _preferences ??= await SharedPreferences.getInstance();

  Future<CachedBundle?> read(String key,
      {Duration? maxAge = const Duration(days: 1)}) async {
    try {
      final store = await _store;
      final raw = store.getString('linguaflow:$key');
      if (raw == null) return null;
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      final envelope = decoded.cast<String, dynamic>();
      final savedAtValue = envelope['savedAt'];
      final savedAt =
          savedAtValue is String ? DateTime.tryParse(savedAtValue) : null;
      if (savedAt == null ||
          (maxAge != null && DateTime.now().difference(savedAt) > maxAge)) {
        return null;
      }
      final etag = envelope['etag'];
      final releaseId = envelope['releaseId'];
      if ((etag != null && etag is! String) ||
          (releaseId != null && releaseId is! String)) {
        return null;
      }
      return CachedBundle(
          data: decodeTranslationBundle(envelope['data']),
          etag: etag as String?,
          releaseId: releaseId as String?);
    } on Object {
      return null;
    }
  }

  Future<void> write(String key, Map<String, dynamic> data,
      {String? etag, String? releaseId}) async {
    final store = await _store;
    await store.setString(
        'linguaflow:$key',
        jsonEncode({
          'savedAt': DateTime.now().toIso8601String(),
          'etag': etag,
          'releaseId': releaseId,
          'data': data
        }));
  }

  Future<void> invalidate(String key) async =>
      (await _store).remove('linguaflow:$key');

  Future<String?> readValue(String key) async =>
      (await _store).getString('linguaflow:value:$key');

  Future<void> writeValue(String key, String value) async {
    await (await _store).setString('linguaflow:value:$key', value);
  }

  Future<void> removeValue(String key) async =>
      (await _store).remove('linguaflow:value:$key');
}
