// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor_values.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SensorValues {
  int get pm2 => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SensorValuesCopyWith<SensorValues> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SensorValuesCopyWith<$Res> {
  factory $SensorValuesCopyWith(
          SensorValues value, $Res Function(SensorValues) then) =
      _$SensorValuesCopyWithImpl<$Res, SensorValues>;
  @useResult
  $Res call({int pm2});
}

/// @nodoc
class _$SensorValuesCopyWithImpl<$Res, $Val extends SensorValues>
    implements $SensorValuesCopyWith<$Res> {
  _$SensorValuesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pm2 = null,
  }) {
    return _then(_value.copyWith(
      pm2: null == pm2
          ? _value.pm2
          : pm2 // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SensorValuesCopyWith<$Res>
    implements $SensorValuesCopyWith<$Res> {
  factory _$$_SensorValuesCopyWith(
          _$_SensorValues value, $Res Function(_$_SensorValues) then) =
      __$$_SensorValuesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int pm2});
}

/// @nodoc
class __$$_SensorValuesCopyWithImpl<$Res>
    extends _$SensorValuesCopyWithImpl<$Res, _$_SensorValues>
    implements _$$_SensorValuesCopyWith<$Res> {
  __$$_SensorValuesCopyWithImpl(
      _$_SensorValues _value, $Res Function(_$_SensorValues) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pm2 = null,
  }) {
    return _then(_$_SensorValues(
      pm2: null == pm2
          ? _value.pm2
          : pm2 // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_SensorValues implements _SensorValues {
  const _$_SensorValues({required this.pm2});

  @override
  final int pm2;

  @override
  String toString() {
    return 'SensorValues(pm2: $pm2)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SensorValues &&
            (identical(other.pm2, pm2) || other.pm2 == pm2));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pm2);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SensorValuesCopyWith<_$_SensorValues> get copyWith =>
      __$$_SensorValuesCopyWithImpl<_$_SensorValues>(this, _$identity);
}

abstract class _SensorValues implements SensorValues {
  const factory _SensorValues({required final int pm2}) = _$_SensorValues;

  @override
  int get pm2;
  @override
  @JsonKey(ignore: true)
  _$$_SensorValuesCopyWith<_$_SensorValues> get copyWith =>
      throw _privateConstructorUsedError;
}
