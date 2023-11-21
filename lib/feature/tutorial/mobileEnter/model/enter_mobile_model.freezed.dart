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
  Data get data => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;

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
  $Res call({Data data, Status status});

  $DataCopyWith<$Res> get data;
  $StatusCopyWith<$Res> get status;
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
    Object? data = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DataCopyWith<$Res> get data {
    return $DataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StatusCopyWith<$Res> get status {
    return $StatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
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
  $Res call({Data data, Status status});

  @override
  $DataCopyWith<$Res> get data;
  @override
  $StatusCopyWith<$Res> get status;
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
    Object? data = null,
    Object? status = null,
  }) {
    return _then(_$EnterMobileModelImpl(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$EnterMobileModelImpl implements _EnterMobileModel {
  const _$EnterMobileModelImpl({required this.data, required this.status});

  factory _$EnterMobileModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$EnterMobileModelImplFromJson(json);

  @override
  final Data data;
  @override
  final Status status;

  @override
  String toString() {
    return 'EnterMobileModel(data: $data, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EnterMobileModelImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data, status);

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
  const factory _EnterMobileModel(
      {required final Data data,
      required final Status status}) = _$EnterMobileModelImpl;

  factory _EnterMobileModel.fromJson(Map<String, dynamic> json) =
      _$EnterMobileModelImpl.fromJson;

  @override
  Data get data;
  @override
  Status get status;
  @override
  @JsonKey(ignore: true)
  _$$EnterMobileModelImplCopyWith<_$EnterMobileModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return _Data.fromJson(json);
}

/// @nodoc
mixin _$Data {
  Item get item => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataCopyWith<Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res, Data>;
  @useResult
  $Res call({Item item});

  $ItemCopyWith<$Res> get item;
}

/// @nodoc
class _$DataCopyWithImpl<$Res, $Val extends Data>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_value.copyWith(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as Item,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ItemCopyWith<$Res> get item {
    return $ItemCopyWith<$Res>(_value.item, (value) {
      return _then(_value.copyWith(item: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DataImplCopyWith<$Res> implements $DataCopyWith<$Res> {
  factory _$$DataImplCopyWith(
          _$DataImpl value, $Res Function(_$DataImpl) then) =
      __$$DataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Item item});

  @override
  $ItemCopyWith<$Res> get item;
}

/// @nodoc
class __$$DataImplCopyWithImpl<$Res>
    extends _$DataCopyWithImpl<$Res, _$DataImpl>
    implements _$$DataImplCopyWith<$Res> {
  __$$DataImplCopyWithImpl(_$DataImpl _value, $Res Function(_$DataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
  }) {
    return _then(_$DataImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as Item,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataImpl implements _Data {
  const _$DataImpl({required this.item});

  factory _$DataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataImplFromJson(json);

  @override
  final Item item;

  @override
  String toString() {
    return 'Data(item: $item)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataImpl &&
            (identical(other.item, item) || other.item == item));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, item);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      __$$DataImplCopyWithImpl<_$DataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataImplToJson(
      this,
    );
  }
}

abstract class _Data implements Data {
  const factory _Data({required final Item item}) = _$DataImpl;

  factory _Data.fromJson(Map<String, dynamic> json) = _$DataImpl.fromJson;

  @override
  Item get item;
  @override
  @JsonKey(ignore: true)
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Item _$ItemFromJson(Map<String, dynamic> json) {
  return _Item.fromJson(json);
}

/// @nodoc
mixin _$Item {
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemCopyWith<$Res> {
  factory $ItemCopyWith(Item value, $Res Function(Item) then) =
      _$ItemCopyWithImpl<$Res, Item>;
}

/// @nodoc
class _$ItemCopyWithImpl<$Res, $Val extends Item>
    implements $ItemCopyWith<$Res> {
  _$ItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$ItemImplCopyWith<$Res> {
  factory _$$ItemImplCopyWith(
          _$ItemImpl value, $Res Function(_$ItemImpl) then) =
      __$$ItemImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ItemImplCopyWithImpl<$Res>
    extends _$ItemCopyWithImpl<$Res, _$ItemImpl>
    implements _$$ItemImplCopyWith<$Res> {
  __$$ItemImplCopyWithImpl(_$ItemImpl _value, $Res Function(_$ItemImpl) _then)
      : super(_value, _then);
}

/// @nodoc
@JsonSerializable()
class _$ItemImpl implements _Item {
  const _$ItemImpl();

  factory _$ItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemImplFromJson(json);

  @override
  String toString() {
    return 'Item()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ItemImpl);
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => runtimeType.hashCode;

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemImplToJson(
      this,
    );
  }
}

abstract class _Item implements Item {
  const factory _Item() = _$ItemImpl;

  factory _Item.fromJson(Map<String, dynamic> json) = _$ItemImpl.fromJson;
}

Status _$StatusFromJson(Map<String, dynamic> json) {
  return _Status.fromJson(json);
}

/// @nodoc
mixin _$Status {
  String get type => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatusCopyWith<Status> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusCopyWith<$Res> {
  factory $StatusCopyWith(Status value, $Res Function(Status) then) =
      _$StatusCopyWithImpl<$Res, Status>;
  @useResult
  $Res call({String type, String message, String description});
}

/// @nodoc
class _$StatusCopyWithImpl<$Res, $Val extends Status>
    implements $StatusCopyWith<$Res> {
  _$StatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StatusImplCopyWith<$Res> implements $StatusCopyWith<$Res> {
  factory _$$StatusImplCopyWith(
          _$StatusImpl value, $Res Function(_$StatusImpl) then) =
      __$$StatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String type, String message, String description});
}

/// @nodoc
class __$$StatusImplCopyWithImpl<$Res>
    extends _$StatusCopyWithImpl<$Res, _$StatusImpl>
    implements _$$StatusImplCopyWith<$Res> {
  __$$StatusImplCopyWithImpl(
      _$StatusImpl _value, $Res Function(_$StatusImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? message = null,
    Object? description = null,
  }) {
    return _then(_$StatusImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusImpl implements _Status {
  const _$StatusImpl(
      {required this.type, required this.message, required this.description});

  factory _$StatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusImplFromJson(json);

  @override
  final String type;
  @override
  final String message;
  @override
  final String description;

  @override
  String toString() {
    return 'Status(type: $type, message: $message, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, message, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StatusImplCopyWith<_$StatusImpl> get copyWith =>
      __$$StatusImplCopyWithImpl<_$StatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StatusImplToJson(
      this,
    );
  }
}

abstract class _Status implements Status {
  const factory _Status(
      {required final String type,
      required final String message,
      required final String description}) = _$StatusImpl;

  factory _Status.fromJson(Map<String, dynamic> json) = _$StatusImpl.fromJson;

  @override
  String get type;
  @override
  String get message;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$StatusImplCopyWith<_$StatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
