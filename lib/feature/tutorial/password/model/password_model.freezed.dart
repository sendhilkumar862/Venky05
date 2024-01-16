// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'password_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PasswordModel _$PasswordModelFromJson(Map<String, dynamic> json) {
  return _PasswordModel.fromJson(json);
}

/// @nodoc
mixin _$PasswordModel {
  Token get token => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PasswordModelCopyWith<PasswordModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordModelCopyWith<$Res> {
  factory $PasswordModelCopyWith(
          PasswordModel value, $Res Function(PasswordModel) then) =
      _$PasswordModelCopyWithImpl<$Res, PasswordModel>;
  @useResult
  $Res call({Token token, String status, String? username});

  $TokenCopyWith<$Res> get token;
}

/// @nodoc
class _$PasswordModelCopyWithImpl<$Res, $Val extends PasswordModel>
    implements $PasswordModelCopyWith<$Res> {
  _$PasswordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? status = null,
    Object? username = freezed,
  }) {
    return _then(_value.copyWith(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as Token,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TokenCopyWith<$Res> get token {
    return $TokenCopyWith<$Res>(_value.token, (value) {
      return _then(_value.copyWith(token: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PasswordModelImplCopyWith<$Res>
    implements $PasswordModelCopyWith<$Res> {
  factory _$$PasswordModelImplCopyWith(
          _$PasswordModelImpl value, $Res Function(_$PasswordModelImpl) then) =
      __$$PasswordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Token token, String status, String? username});

  @override
  $TokenCopyWith<$Res> get token;
}

/// @nodoc
class __$$PasswordModelImplCopyWithImpl<$Res>
    extends _$PasswordModelCopyWithImpl<$Res, _$PasswordModelImpl>
    implements _$$PasswordModelImplCopyWith<$Res> {
  __$$PasswordModelImplCopyWithImpl(
      _$PasswordModelImpl _value, $Res Function(_$PasswordModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? token = null,
    Object? status = null,
    Object? username = freezed,
  }) {
    return _then(_$PasswordModelImpl(
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as Token,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PasswordModelImpl implements _PasswordModel {
  const _$PasswordModelImpl(
      {required this.token, required this.status, this.username});

  factory _$PasswordModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PasswordModelImplFromJson(json);

  @override
  final Token token;
  @override
  final String status;
  @override
  final String? username;

  @override
  String toString() {
    return 'PasswordModel(token: $token, status: $status, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordModelImpl &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, token, status, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordModelImplCopyWith<_$PasswordModelImpl> get copyWith =>
      __$$PasswordModelImplCopyWithImpl<_$PasswordModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PasswordModelImplToJson(
      this,
    );
  }
}

abstract class _PasswordModel implements PasswordModel {
  const factory _PasswordModel(
      {required final Token token,
      required final String status,
      final String? username}) = _$PasswordModelImpl;

  factory _PasswordModel.fromJson(Map<String, dynamic> json) =
      _$PasswordModelImpl.fromJson;

  @override
  Token get token;
  @override
  String get status;
  @override
  String? get username;
  @override
  @JsonKey(ignore: true)
  _$$PasswordModelImplCopyWith<_$PasswordModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Token _$TokenFromJson(Map<String, dynamic> json) {
  return _Token.fromJson(json);
}

/// @nodoc
mixin _$Token {
  String get accessToken => throw _privateConstructorUsedError;
  int get accessTokenExpiryTime => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;
  int get refreshTokenExpiryTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokenCopyWith<Token> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokenCopyWith<$Res> {
  factory $TokenCopyWith(Token value, $Res Function(Token) then) =
      _$TokenCopyWithImpl<$Res, Token>;
  @useResult
  $Res call(
      {String accessToken,
      int accessTokenExpiryTime,
      String refreshToken,
      int refreshTokenExpiryTime});
}

/// @nodoc
class _$TokenCopyWithImpl<$Res, $Val extends Token>
    implements $TokenCopyWith<$Res> {
  _$TokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? accessTokenExpiryTime = null,
    Object? refreshToken = null,
    Object? refreshTokenExpiryTime = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      accessTokenExpiryTime: null == accessTokenExpiryTime
          ? _value.accessTokenExpiryTime
          : accessTokenExpiryTime // ignore: cast_nullable_to_non_nullable
              as int,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshTokenExpiryTime: null == refreshTokenExpiryTime
          ? _value.refreshTokenExpiryTime
          : refreshTokenExpiryTime // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TokenImplCopyWith<$Res> implements $TokenCopyWith<$Res> {
  factory _$$TokenImplCopyWith(
          _$TokenImpl value, $Res Function(_$TokenImpl) then) =
      __$$TokenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String accessToken,
      int accessTokenExpiryTime,
      String refreshToken,
      int refreshTokenExpiryTime});
}

/// @nodoc
class __$$TokenImplCopyWithImpl<$Res>
    extends _$TokenCopyWithImpl<$Res, _$TokenImpl>
    implements _$$TokenImplCopyWith<$Res> {
  __$$TokenImplCopyWithImpl(
      _$TokenImpl _value, $Res Function(_$TokenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? accessTokenExpiryTime = null,
    Object? refreshToken = null,
    Object? refreshTokenExpiryTime = null,
  }) {
    return _then(_$TokenImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      accessTokenExpiryTime: null == accessTokenExpiryTime
          ? _value.accessTokenExpiryTime
          : accessTokenExpiryTime // ignore: cast_nullable_to_non_nullable
              as int,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshTokenExpiryTime: null == refreshTokenExpiryTime
          ? _value.refreshTokenExpiryTime
          : refreshTokenExpiryTime // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TokenImpl implements _Token {
  const _$TokenImpl(
      {required this.accessToken,
      required this.accessTokenExpiryTime,
      required this.refreshToken,
      required this.refreshTokenExpiryTime});

  factory _$TokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokenImplFromJson(json);

  @override
  final String accessToken;
  @override
  final int accessTokenExpiryTime;
  @override
  final String refreshToken;
  @override
  final int refreshTokenExpiryTime;

  @override
  String toString() {
    return 'Token(accessToken: $accessToken, accessTokenExpiryTime: $accessTokenExpiryTime, refreshToken: $refreshToken, refreshTokenExpiryTime: $refreshTokenExpiryTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokenImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.accessTokenExpiryTime, accessTokenExpiryTime) ||
                other.accessTokenExpiryTime == accessTokenExpiryTime) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken) &&
            (identical(other.refreshTokenExpiryTime, refreshTokenExpiryTime) ||
                other.refreshTokenExpiryTime == refreshTokenExpiryTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken,
      accessTokenExpiryTime, refreshToken, refreshTokenExpiryTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokenImplCopyWith<_$TokenImpl> get copyWith =>
      __$$TokenImplCopyWithImpl<_$TokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokenImplToJson(
      this,
    );
  }
}

abstract class _Token implements Token {
  const factory _Token(
      {required final String accessToken,
      required final int accessTokenExpiryTime,
      required final String refreshToken,
      required final int refreshTokenExpiryTime}) = _$TokenImpl;

  factory _Token.fromJson(Map<String, dynamic> json) = _$TokenImpl.fromJson;

  @override
  String get accessToken;
  @override
  int get accessTokenExpiryTime;
  @override
  String get refreshToken;
  @override
  int get refreshTokenExpiryTime;
  @override
  @JsonKey(ignore: true)
  _$$TokenImplCopyWith<_$TokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
