import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dio/dio.dart';
import 'package:insta_sensors/config/sensor_config.dart';

import '../config/config.dart';
part 'sensor_values.freezed.dart';

@freezed
class SensorValues with _$SensorValues {
  const factory SensorValues({
    required int pm2,
  }) = _SensorValues;
}

final dioProvider = Provider((ref) => Dio());

final sensorValuesNotifierProviderFamily = FutureProvider.autoDispose.family<SensorValues, String>((ref, uid) async {
  Dio dio = ref.read(dioProvider);
  final Config config = ref.watch(configNotifierProvider);

  final SensorConfig sensorConfig = config.sensors.firstWhere((item) => item.uid == uid);
  final auth = 'Basic ${base64Encode(utf8.encode("${sensorConfig.username}:${sensorConfig.password}"))}';
  final Map<String, String> queryParams = {
    'cmnd': 'status 10',
    'user': sensorConfig.username,
    'password': sensorConfig.password,
  };
  final Uri uri = Uri(
    scheme: 'http',
    host: sensorConfig.host,
    port: sensorConfig.port,
    path: '/cm',
    queryParameters: queryParams,
  );
  final response = await dio.getUri(uri);
  print(response.data.toString());
  return SensorValues(pm2: response.data['StatusSNS']['VINDRIKTNING']['PM2.5'] ?? -1);
});