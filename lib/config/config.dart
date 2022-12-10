import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insta_sensors/config/sensor_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../state/sensor_values.dart';
part 'config.freezed.dart';
part 'config.g.dart';

@freezed
class Config with _$Config {
  const factory Config({
    required List<SensorConfig> sensors,
  }) = _Config;

  factory Config.fromJson(Map<String, Object?> json) => _$ConfigFromJson(json);
}

class PersistentStore {
  final _store = const FlutterSecureStorage();

  Future<void> set(String key, String? value) async {
    _store.write(key: key, value: value);
  }

  Future<String?> get(String key) async {
    return _store.read(key: key);
  }

  Future<void> remove(String key) async {
    return _store.delete(key: key);
  }
}

@riverpod
class ConfigNotifier extends _$ConfigNotifier {
  final PersistentStore store = PersistentStore();
  @override
  Config build() {
    return const Config(sensors: []);
  }

  Future<void> init() async {
    // final store = LocalStorage('insta-sensors.json');
    final json = await store.get('config');
    if (json != null) {
      state = Config.fromJson(jsonDecode(json));
    }
  }

  Future<void> _saveConfig() async {
    final json = jsonEncode(state.toJson());
    store.set('config', json);
  }

  Future<void> setSensor(SensorConfig sensor) async {
    try {
      SensorConfig existingSensor = state.sensors.firstWhere((item) =>
      item.uid == sensor.uid);
      // Replace existing item
      List<SensorConfig> sensorsCopy = [...state.sensors];
      int idx = sensorsCopy.indexOf(existingSensor);
      sensorsCopy.remove(existingSensor);
      sensorsCopy.insert(idx, sensor);
      state = state.copyWith(sensors: sensorsCopy);
    } catch(ignored) {
      // Add new item
      state = state.copyWith(sensors: [...state.sensors, sensor]);
    }
    await _saveConfig();
    ref.refresh(configNotifierProvider);
  }

  Future<void> removeSensor(SensorConfig sensor) async {
    List<SensorConfig> sensorsCopy = [...state.sensors];
    sensorsCopy.removeWhere((item) => item.uid == sensor.uid);
    state = state.copyWith(sensors: sensorsCopy);
    _saveConfig();
  }
}
