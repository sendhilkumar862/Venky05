// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_mobile_update_otp_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VerifyMobileUpdateOTPRequestModel _$VerifyMobileUpdateOTPRequestModelFromJson(
    Map<String, dynamic> json) {
  return _VerifyMobileUpdateOTPRequestModel.fromJson(json);
}

/// @nodoc
mixin _$VerifyMobileUpdateOTPRequestModel {
  String get userId => throw _privateConstructorUsedError;
  String get otpId => throw _privateConstructorUsedError;
  String get otp => throw _privateConstructorUsedError;
  bool get isMobileUpdation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyMobileUpdateOTPRequestModelCopyWith<VerifyMobileUpdateOTPRequestModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyMobileUpdateOTPRequestModelCopyWith<$Res> {
  factory $VerifyMobileUpdateOTPRequestModelCopyWith(
          VerifyMobileUpdateOTPRequestModel value,
          $Res Function(VerifyMobileUpdateOTPRequestModel) then) =
      _$VerifyMobileUpdateOTPRequestModelCopyWithImpl<$Res,
          VerifyMobileUpdateOTPRequestModel>;
  @useResult
  $Res call({String userId, String otpId, String otp, bool isMobileUpdation});
}

/// @nodoc
class _$VerifyMobileUpdateOTPRequestModelCopyWithImpl<$Res,
        $Val extends VerifyMobileUpdateOTPRequestModel>
    implements $VerifyMobileUpdateOTPRequestModelCopyWith<$Res> {
  _$VerifyMobileUpdateOTPRequestModelCopyWithImpl(this._value, this._then);

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
    Object? isMobileUpdation = null,
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
      isMobileUpdation: null == isMobileUpdation
          ? _value.isMobileUpdation
          : isMobileUpdation // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerifyMobileUpdateOTPRequestModelImplCopyWith<$Res>
    implements $VerifyMobileUpdateOTPRequestModelCopyWith<$Res> {
  factory _$$VerifyMobileUpdateOTPRequestModelImplCopyWith(
          _$VerifyMobileUpdateOTPRequestModelImpl value,
          $Res Function(_$VerifyMobileUpdateOTPRequestModelImpl) then) =
      __$$VerifyMobileUpdateOTPRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String otpId, String otp, bool isMobileUpdation});
}

/// @nodoc
class __$$VerifyMobileUpdateOTPRequestModelImplCopyWithImpl<$Res>
    extends _$VerifyMobileUpdateOTPRequestModelCopyWithImpl<$Res,
        _$VerifyMobileUpdateOTPRequestModelImpl>
    implements _$$VerifyMobileUpdateOTPRequestModelImplCopyWith<$Res> {
  __$$VerifyMobileUpdateOTPRequestModelImplCopyWithImpl(
      _$VerifyMobileUpdateOTPRequestModelImpl _value,
      $Res Function(_$VerifyMobileUpdateOTPRequestModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? otpId = null,
    Object? otp = null,
    Object? isMobileUpdation = null,
  }) {
    return _then(_$VerifyMobileUpdateOTPRequestModelImpl(
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
      isMobileUpdation: null == isMobileUpdation
          ? _value.isMobileUpdation
          : isMobileUpdation // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerifyMobileUpdateOTPRequestModelImpl
    implements _VerifyMobileUpdateOTPRequestModel {
  const _$VerifyMobileUpdateOTPRequestModelImpl(
      {required this.userId,
      required this.otpId,
      required this.otp,
      required this.isMobileUpdation});

  factory _$VerifyMobileUpdateOTPRequestModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$VerifyMobileUpdateOTPRequestModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String otpId;
  @override
  final String otp;
  @override
  final bool isMobileUpdation;

  @override
  String toString() {
    return 'VerifyMobileUpdateOTPRequestModel(userId: $userId, otpId: $otpId, otp: $otp, isMobileUpdation: $isMobileUpdation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyMobileUpdateOTPRequestModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.otpId, otpId) || other.otpId == otpId) &&
            (identical(other.otp, otp) || other.otp == otp) &&
            (identical(other.isMobileUpdation, isMobileUpdation) ||
                other.isMobileUpdation == isMobileUpdation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, otpId, otp, isMobileUpdation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerifyMobileUpdateOTPRequestModelImplCopyWith<
          _$VerifyMobileUpdateOTPRequestModelImpl>
      get copyWith => __$$VerifyMobileUpdateOTPRequestModelImplCopyWithImpl<
          _$VerifyMobileUpdateOTPRequestModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyMobileUpdateOTPRequestModelImplToJson(
      this,
    );
  }
}

abstract class _VerifyMobileUpdateOTPRequestModel
    implements VerifyMobileUpdateOTPRequestModel {
  const factory _VerifyMobileUpdateOTPRequestModel(
          {required final String userId,
          required final String otpId,
          required final String otp,
          required final bool isMobileUpdation}) =
      _$VerifyMobileUpdateOTPRequestModelImpl;

  factory _VerifyMobileUpdateOTPRequestModel.fromJson(
          Map<String, dynamic> json) =
      _$VerifyMobileUpdateOTPRequestModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get otpId;
  @override
  String get otp;
  @override
  bool get isMobileUpdation;
  @override
  @JsonKey(ignore: true)
  _$$VerifyMobileUpdateOTPRequestModelImplCopyWith<
          _$VerifyMobileUpdateOTPRequestModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
