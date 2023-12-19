// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_enter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EmailEnterModel _$EmailEnterModelFromJson(Map<String, dynamic> json) {
  return _EmailEnterModel.fromJson(json);
}

/// @nodoc
mixin _$EmailEnterModel {
  int? get userId => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EmailEnterModelCopyWith<EmailEnterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailEnterModelCopyWith<$Res> {
  factory $EmailEnterModelCopyWith(
          EmailEnterModel value, $Res Function(EmailEnterModel) then) =
      _$EmailEnterModelCopyWithImpl<$Res, EmailEnterModel>;
  @useResult
  $Res call({int? userId, String? status});
}

/// @nodoc
class _$EmailEnterModelCopyWithImpl<$Res, $Val extends EmailEnterModel>
    implements $EmailEnterModelCopyWith<$Res> {
  _$EmailEnterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EmailEnterModelImplCopyWith<$Res>
    implements $EmailEnterModelCopyWith<$Res> {
  factory _$$EmailEnterModelImplCopyWith(_$EmailEnterModelImpl value,
          $Res Function(_$EmailEnterModelImpl) then) =
      __$$EmailEnterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? userId, String? status});
}

/// @nodoc
class __$$EmailEnterModelImplCopyWithImpl<$Res>
    extends _$EmailEnterModelCopyWithImpl<$Res, _$EmailEnterModelImpl>
    implements _$$EmailEnterModelImplCopyWith<$Res> {
  __$$EmailEnterModelImplCopyWithImpl(
      _$EmailEnterModelImpl _value, $Res Function(_$EmailEnterModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? status = freezed,
  }) {
    return _then(_$EmailEnterModelImpl(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EmailEnterModelImpl implements _EmailEnterModel {
  const _$EmailEnterModelImpl({this.userId, this.status});

  factory _$EmailEnterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EmailEnterModelImplFromJson(json);

  @override
  final int? userId;
  @override
  final String? status;

  @override
  String toString() {
    return 'EmailEnterModel(userId: $userId, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailEnterModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailEnterModelImplCopyWith<_$EmailEnterModelImpl> get copyWith =>
      __$$EmailEnterModelImplCopyWithImpl<_$EmailEnterModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailEnterModelImplToJson(
      this,
    );
  }
}

abstract class _EmailEnterModel implements EmailEnterModel {
  const factory _EmailEnterModel({final int? userId, final String? status}) =
      _$EmailEnterModelImpl;

  factory _EmailEnterModel.fromJson(Map<String, dynamic> json) =
      _$EmailEnterModelImpl.fromJson;

  @override
  int? get userId;
  @override
  String? get status;
  @override
  @JsonKey(ignore: true)
  _$$EmailEnterModelImplCopyWith<_$EmailEnterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
