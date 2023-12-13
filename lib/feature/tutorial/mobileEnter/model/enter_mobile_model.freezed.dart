// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'enter_mobile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EnterMobileModel _$EnterMobileModelFromJson(Map<String, dynamic> json) {
  return _EnterMobileModel.fromJson(json);
}

/// @nodoc
mixin _$EnterMobileModel {
  int? get otpId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EnterMobileModelCopyWith<EnterMobileModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnterMobileModelCopyWith<$Res> {
  factory $EnterMobileModelCopyWith(
          EnterMobileModel value, $Res Function(EnterMobileModel) then) =
      _$EnterMobileModelCopyWithImpl<$Res, EnterMobileModel>;
  @useResult
  $Res call({int? otpId});
}

/// @nodoc
class _$EnterMobileModelCopyWithImpl<$Res, $Val extends EnterMobileModel>
    implements $EnterMobileModelCopyWith<$Res> {
  _$EnterMobileModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpId = freezed,
  }) {
    return _then(_value.copyWith(
      otpId: freezed == otpId
          ? _value.otpId
          : otpId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EnterMobileModelImplCopyWith<$Res>
    implements $EnterMobileModelCopyWith<$Res> {
  factory _$$EnterMobileModelImplCopyWith(_$EnterMobileModelImpl value,
          $Res Function(_$EnterMobileModelImpl) then) =
      __$$EnterMobileModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? otpId});
}

/// @nodoc
class __$$EnterMobileModelImplCopyWithImpl<$Res>
    extends _$EnterMobileModelCopyWithImpl<$Res, _$EnterMobileModelImpl>
    implements _$$EnterMobileModelImplCopyWith<$Res> {
  __$$EnterMobileModelImplCopyWithImpl(_$EnterMobileModelImpl _value,
      $Res Function(_$EnterMobileModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? otpId = freezed,
  }) {
    return _then(_$EnterMobileModelImpl(
      otpId: freezed == otpId
          ? _value.otpId
          : otpId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnterMobileModelImpl implements _EnterMobileModel {
  const _$EnterMobileModelImpl({this.otpId});

  factory _$EnterMobileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnterMobileModelImplFromJson(json);

  @override
  final int? otpId;

  @override
  String toString() {
    return 'EnterMobileModel(otpId: $otpId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnterMobileModelImpl &&
            (identical(other.otpId, otpId) || other.otpId == otpId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, otpId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EnterMobileModelImplCopyWith<_$EnterMobileModelImpl> get copyWith =>
      __$$EnterMobileModelImplCopyWithImpl<_$EnterMobileModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EnterMobileModelImplToJson(
      this,
    );
  }
}

abstract class _EnterMobileModel implements EnterMobileModel {
  const factory _EnterMobileModel({final int? otpId}) = _$EnterMobileModelImpl;

  factory _EnterMobileModel.fromJson(Map<String, dynamic> json) =
      _$EnterMobileModelImpl.fromJson;

  @override
  int? get otpId;
  @override
  @JsonKey(ignore: true)
  _$$EnterMobileModelImplCopyWith<_$EnterMobileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
