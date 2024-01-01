// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_otp_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VerifyOTPRequestModel _$VerifyOTPRequestModelFromJson(
    Map<String, dynamic> json) {
  return _VerifyOTPRequestModel.fromJson(json);
}

/// @nodoc
mixin _$VerifyOTPRequestModel {
  String get userId => throw _privateConstructorUsedError;
  String get otpId => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyOTPRequestModelCopyWith<VerifyOTPRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyOTPRequestModelCopyWith<$Res> {
  factory $VerifyOTPRequestModelCopyWith(VerifyOTPRequestModel value,
          $Res Function(VerifyOTPRequestModel) then) =
      _$VerifyOTPRequestModelCopyWithImpl<$Res, VerifyOTPRequestModel>;
  @useResult
  $Res call({String userId, String otpId, String otp});
}

/// @nodoc
class _$VerifyOTPRequestModelCopyWithImpl<$Res,
        $Val extends VerifyOTPRequestModel>
    implements $VerifyOTPRequestModelCopyWith<$Res> {
  _$VerifyOTPRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? otpId = null,
    Object? otp = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      otpId: null == otpId
          ? _value.otpId
          : otpId // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyOTPRequestModelImplCopyWith<$Res>
    implements $VerifyOTPRequestModelCopyWith<$Res> {
  factory _$$VerifyOTPRequestModelImplCopyWith(
          _$VerifyOTPRequestModelImpl value,
          $Res Function(_$VerifyOTPRequestModelImpl) then) =
      __$$VerifyOTPRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String otpId, String otp});
}

/// @nodoc
class __$$VerifyOTPRequestModelImplCopyWithImpl<$Res>
    extends _$VerifyOTPRequestModelCopyWithImpl<$Res,
        _$VerifyOTPRequestModelImpl>
    implements _$$VerifyOTPRequestModelImplCopyWith<$Res> {
  __$$VerifyOTPRequestModelImplCopyWithImpl(_$VerifyOTPRequestModelImpl _value,
      $Res Function(_$VerifyOTPRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? otpId = null,
    Object? otp = null,
  }) {
    return _then(_$VerifyOTPRequestModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      otpId: null == otpId
          ? _value.otpId
          : otpId // ignore: cast_nullable_to_non_nullable
              as String,
      otp: null == otp
          ? _value.otp
          : otp // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyOTPRequestModelImpl implements _VerifyOTPRequestModel {
  const _$VerifyOTPRequestModelImpl(
      {required this.userId, required this.otpId, required this.otp});

  factory _$VerifyOTPRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyOTPRequestModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String otpId;
  @override
  final String otp;

  @override
  String toString() {
    return 'VerifyOTPRequestModel(userId: $userId, otpId: $otpId, otp: $otp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyOTPRequestModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.otpId, otpId) || other.otpId == otpId) &&
            (identical(other.otp, otp) || other.otp == otp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, otpId, otp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyOTPRequestModelImplCopyWith<_$VerifyOTPRequestModelImpl>
      get copyWith => __$$VerifyOTPRequestModelImplCopyWithImpl<
          _$VerifyOTPRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyOTPRequestModelImplToJson(
      this,
    );
  }
}

abstract class _VerifyOTPRequestModel implements VerifyOTPRequestModel {
  const factory _VerifyOTPRequestModel(
      {required final String userId,
      required final String otpId,
      required final String otp}) = _$VerifyOTPRequestModelImpl;

  factory _VerifyOTPRequestModel.fromJson(Map<String, dynamic> json) =
      _$VerifyOTPRequestModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get otpId;
  @override
  String get otp;
  @override
  @JsonKey(ignore: true)
  _$$VerifyOTPRequestModelImplCopyWith<_$VerifyOTPRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
