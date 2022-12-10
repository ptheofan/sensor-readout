// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SensorConfig _$$_SensorConfigFromJson(Map<String, dynamic> json) =>
    _$_SensorConfig(
      uid: json['uid'] as String,
      name: json['name'] as String,
      host: json['host'] as String,
      port: json['port'] as int,
      username: json['username'] as String,
      password: json['password'] as String,
      type: $enumDecode(_$SensorTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$$_SensorConfigToJson(_$_SensorConfig instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'host': instance.host,
      'port': instance.port,
      'username': instance.username,
      'password': instance.password,
      'type': _$SensorTypeEnumMap[instance.type]!,
    };

const _$SensorTypeEnumMap = {
  SensorType.tasmotaVindrikthing: 'tasmotaVindrikthing',
};
