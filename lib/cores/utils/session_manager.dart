import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:skeen/cores/cores.dart';

const localCacheBox = "local_cache";

final sessionManagerProvider = Provider<SessionManager>(
  (ref) => SessionManager(),
);

class SessionManager {
  late final Box _localCache;

  SessionManager() {
    _localCache = Hive.box(localCacheBox);
  }

  Future<void> storeObject<T>(
    String key,
    T object,
    Map<String, dynamic> Function(T obj) toJson,
  ) async {
    final json = toJson(object);
    final jsonString = jsonEncode(json);
    await _localCache.put(key, jsonString);
  }

  T? getCachedObject<T>(
    String key,
    T Function(Map<String, dynamic> json) fromJson,
  ) {
    final jsonString = _localCache.get(key);
    if (jsonString != null && jsonString.isNotEmpty) {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return fromJson(json);
    }
    return null;
  }

  Future<void> storeObjectList<T>(
    String listKey,
    List<T> objects,
    Map<String, dynamic> Function(T obj) toJson,
  ) async {
    try {
      List<Map<String, dynamic>> jsonList = objects.map(toJson).toList();
      String jsonString = jsonEncode(jsonList);
      await _localCache.put(listKey, jsonString);
    } catch (e) {
      AppLogger.logError(
        "Error trying to store List of Objects in cached memory",
      );
    }
  }

  List<T>? getObjectList<T>(
    String listKey,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    try {
      String? jsonString = _localCache.get(listKey);
      if (jsonString != null) {
        List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList
            .map((json) => fromJson(json as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      AppLogger.logError(
        "Error trying to get List of Objects from cached memory",
      );
    }

    return null;
  }

  Future<void> deleteStoredBuiltInType(String key) async {
    await _localCache.delete(key);
  }

  Future<void> storeBool(String key, bool value) async {
    await _localCache.put(key, value);
  }

  bool? getBool(String key) {
    return _localCache.get(key) as bool?;
  }
}
