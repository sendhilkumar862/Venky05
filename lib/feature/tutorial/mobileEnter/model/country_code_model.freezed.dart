// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'country_code_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CountryCodeModel _$CountryCodeModelFromJson(Map<String, dynamic> json) {
  return _CountryCodeModel.fromJson(json);
}

/// @nodoc
mixin _$CountryCodeModel {
  String? get name => throw _privateConstructorUsedError;
  String? get flag_url => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  String? get idd_code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CountryCodeModelCopyWith<CountryCodeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryCodeModelCopyWith<$Res> {
  factory $CountryCodeModelCopyWith(
          CountryCodeModel value, $Res Function(CountryCodeModel) then) =
      _$CountryCodeModelCopyWithImpl<$Res, CountryCodeModel>;
  @useResult
  $Res call({String? name, String? flag_url, String? code, String? idd_code});
}

/// @nodoc
class _$CountryCodeModelCopyWithImpl<$Res, $Val extends CountryCodeModel>
    implements $CountryCodeModelCopyWith<$Res> {
  _$CountryCodeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? flag_url = freezed,
    Object? code = freezed,
    Object? idd_code = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      flag_url: freezed == flag_url
          ? _value.flag_url
          : flag_url // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      idd_code: freezed == idd_code
          ? _value.idd_code
          : idd_code // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CountryCodeModelImplCopyWith<$Res>
    implements $CountryCodeModelCopyWith<$Res> {
  factory _$$CountryCodeModelImplCopyWith(_$CountryCodeModelImpl value,
          $Res Function(_$CountryCodeModelImpl) then) =
      __$$CountryCodeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? name, String? flag_url, String? code, String? idd_code});
}

/// @nodoc
class __$$CountryCodeModelImplCopyWithImpl<$Res>
    extends _$CountryCodeModelCopyWithImpl<$Res, _$CountryCodeModelImpl>
    implements _$$CountryCodeModelImplCopyWith<$Res> {
  __$$CountryCodeModelImplCopyWithImpl(_$CountryCodeModelImpl _value,
      $Res Function(_$CountryCodeModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? flag_url = freezed,
    Object? code = freezed,
    Object? idd_code = freezed,
  }) {
    return _then(_$CountryCodeModelImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      flag_url: freezed == flag_url
          ? _value.flag_url
          : flag_url // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      idd_code: freezed == idd_code
          ? _value.idd_code
          : idd_code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CountryCodeModelImpl implements _CountryCodeModel {
  const _$CountryCodeModelImpl(
      {required this.name,
      required this.flag_url,
      required this.code,
      required this.idd_code});

  factory _$CountryCodeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CountryCodeModelImplFromJson(json);

  @override
  final String? name;
  @override
  final String? flag_url;
  @override
  final String? code;
  @override
  final String? idd_code;

  @override
  String toString() {
    return 'CountryCodeModel(name: $name, flag_url: $flag_url, code: $code, idd_code: $idd_code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CountryCodeModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.flag_url, flag_url) ||
                other.flag_url == flag_url) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.idd_code, idd_code) ||
                other.idd_code == idd_code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, flag_url, code, idd_code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CountryCodeModelImplCopyWith<_$CountryCodeModelImpl> get copyWith =>
      __$$CountryCodeModelImplCopyWithImpl<_$CountryCodeModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CountryCodeModelImplToJson(
      this,
    );
  }
}

abstract class _CountryCodeModel implements CountryCodeModel {
  const factory _CountryCodeModel(
      {required final String? name,
      required final String? flag_url,
      required final String? code,
      required final String? idd_code}) = _$CountryCodeModelImpl;

  factory _CountryCodeModel.fromJson(Map<String, dynamic> json) =
      _$CountryCodeModelImpl.fromJson;

  @override
  String? get name;
  @override
  String? get flag_url;
  @override
  String? get code;
  @override
  String? get idd_code;
  @override
  @JsonKey(ignore: true)
  _$$CountryCodeModelImplCopyWith<_$CountryCodeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
