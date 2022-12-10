import 'package:freezed_annotation/freezed_annotation.dart';
part 'sensor_config.freezed.dart';
part 'sensor_config.g.dart';

enum SensorType {
  tasmotaVindrikthing,
}

const sensorTypes = {
  SensorType.tasmotaVindrikthing: 'Tasmota Vindrinkthing',
};

const sensorIcons = {
  SensorType.tasmotaVindrikthing: 'assets/vindrinkthing.png',
};

@freezed
class SensorConfig with _$SensorConfig {
  const factory SensorConfig({
    required String uid,
    required String name,
    required String host,
    required int port,
    required String username,
    required String password,
    required SensorType type,
  }) = _SensorConfig;

  factory SensorConfig.fromJson(Map<String, Object?> json) => _$SensorConfigFromJson(json);
}
