// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SensorConfig _$SensorConfigFromJson(Map<String, dynamic> json) {
  return _SensorConfig.fromJson(json);
}

/// @nodoc
mixin _$SensorConfig {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get host => throw _privateConstructorUsedError;
  int get port => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  SensorType get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SensorConfigCopyWith<SensorConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SensorConfigCopyWith<$Res> {
  factory $SensorConfigCopyWith(
          SensorConfig value, $Res Function(SensorConfig) then) =
      _$SensorConfigCopyWithImpl<$Res, SensorConfig>;
  @useResult
  $Res call(
      {String uid,
      String name,
      String host,
      int port,
      String username,
      String password,
      SensorType type});
}

/// @nodoc
class _$SensorConfigCopyWithImpl<$Res, $Val extends SensorConfig>
    implements $SensorConfigCopyWith<$Res> {
  _$SensorConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? host = null,
    Object? port = null,
    Object? username = null,
    Object? password = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SensorType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SensorConfigCopyWith<$Res>
    implements $SensorConfigCopyWith<$Res> {
  factory _$$_SensorConfigCopyWith(
          _$_SensorConfig value, $Res Function(_$_SensorConfig) then) =
      __$$_SensorConfigCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      String host,
      int port,
      String username,
      String password,
      SensorType type});
}

/// @nodoc
class __$$_SensorConfigCopyWithImpl<$Res>
    extends _$SensorConfigCopyWithImpl<$Res, _$_SensorConfig>
    implements _$$_SensorConfigCopyWith<$Res> {
  __$$_SensorConfigCopyWithImpl(
      _$_SensorConfig _value, $Res Function(_$_SensorConfig) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? host = null,
    Object? port = null,
    Object? username = null,
    Object? password = null,
    Object? type = null,
  }) {
    return _then(_$_SensorConfig(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      host: null == host
          ? _value.host
          : host // ignore: cast_nullable_to_non_nullable
              as String,
      port: null == port
          ? _value.port
          : port // ignore: cast_nullable_to_non_nullable
              as int,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as SensorType,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SensorConfig extends _SensorConfig {
  const _$_SensorConfig(
      {required this.uid,
      required this.name,
      required this.host,
      required this.port,
      required this.username,
      required this.password,
      required this.type})
      : super._();

  factory _$_SensorConfig.fromJson(Map<String, dynamic> json) =>
      _$$_SensorConfigFromJson(json);

  @override
  final String uid;
  @override
  final String name;
  @override
  final String host;
  @override
  final int port;
  @override
  final String username;
  @override
  final String password;
  @override
  final SensorType type;

  @override
  String toString() {
    return 'SensorConfig(uid: $uid, name: $name, host: $host, port: $port, username: $username, password: $password, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SensorConfig &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.host, host) || other.host == host) &&
            (identical(other.port, port) || other.port == port) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, name, host, port, username, password, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SensorConfigCopyWith<_$_SensorConfig> get copyWith =>
      __$$_SensorConfigCopyWithImpl<_$_SensorConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SensorConfigToJson(
      this,
    );
  }
}

abstract class _SensorConfig extends SensorConfig {
  const factory _SensorConfig(
      {required final String uid,
      required final String name,
      required final String host,
      required final int port,
      required final String username,
      required final String password,
      required final SensorType type}) = _$_SensorConfig;
  const _SensorConfig._() : super._();

  factory _SensorConfig.fromJson(Map<String, dynamic> json) =
      _$_SensorConfig.fromJson;

  @override
  String get uid;
  @override
  String get name;
  @override
  String get host;
  @override
  int get port;
  @override
  String get username;
  @override
  String get password;
  @override
  SensorType get type;
  @override
  @JsonKey(ignore: true)
  _$$_SensorConfigCopyWith<_$_SensorConfig> get copyWith =>
      throw _privateConstructorUsedError;
}
