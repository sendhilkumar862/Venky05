// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'term_and_condition_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TermAndConditionModel _$TermAndConditionModelFromJson(
    Map<String, dynamic> json) {
  return _TermAndConditionModel.fromJson(json);
}

/// @nodoc
mixin _$TermAndConditionModel {
  Data? get data => throw _privateConstructorUsedError;
  Status? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TermAndConditionModelCopyWith<TermAndConditionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermAndConditionModelCopyWith<$Res> {
  factory $TermAndConditionModelCopyWith(TermAndConditionModel value,
          $Res Function(TermAndConditionModel) then) =
      _$TermAndConditionModelCopyWithImpl<$Res, TermAndConditionModel>;
  @useResult
  $Res call({Data? data, Status? status});

  $DataCopyWith<$Res>? get data;
  $StatusCopyWith<$Res>? get status;
}

/// @nodoc
class _$TermAndConditionModelCopyWithImpl<$Res,
        $Val extends TermAndConditionModel>
    implements $TermAndConditionModelCopyWith<$Res> {
  _$TermAndConditionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $DataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StatusCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $StatusCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TermAndConditionModelImplCopyWith<$Res>
    implements $TermAndConditionModelCopyWith<$Res> {
  factory _$$TermAndConditionModelImplCopyWith(
          _$TermAndConditionModelImpl value,
          $Res Function(_$TermAndConditionModelImpl) then) =
      __$$TermAndConditionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Data? data, Status? status});

  @override
  $DataCopyWith<$Res>? get data;
  @override
  $StatusCopyWith<$Res>? get status;
}

/// @nodoc
class __$$TermAndConditionModelImplCopyWithImpl<$Res>
    extends _$TermAndConditionModelCopyWithImpl<$Res,
        _$TermAndConditionModelImpl>
    implements _$$TermAndConditionModelImplCopyWith<$Res> {
  __$$TermAndConditionModelImplCopyWithImpl(_$TermAndConditionModelImpl _value,
      $Res Function(_$TermAndConditionModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? status = freezed,
  }) {
    return _then(_$TermAndConditionModelImpl(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Data?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TermAndConditionModelImpl implements _TermAndConditionModel {
  const _$TermAndConditionModelImpl({this.data, this.status});

  factory _$TermAndConditionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TermAndConditionModelImplFromJson(json);

  @override
  final Data? data;
  @override
  final Status? status;

  @override
  String toString() {
    return 'TermAndConditionModel(data: $data, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermAndConditionModelImpl &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TermAndConditionModelImplCopyWith<_$TermAndConditionModelImpl>
      get copyWith => __$$TermAndConditionModelImplCopyWithImpl<
          _$TermAndConditionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermAndConditionModelImplToJson(
      this,
    );
  }
}

abstract class _TermAndConditionModel implements TermAndConditionModel {
  const factory _TermAndConditionModel(
      {final Data? data, final Status? status}) = _$TermAndConditionModelImpl;

  factory _TermAndConditionModel.fromJson(Map<String, dynamic> json) =
      _$TermAndConditionModelImpl.fromJson;

  @override
  Data? get data;
  @override
  Status? get status;
  @override
  @JsonKey(ignore: true)
  _$$TermAndConditionModelImplCopyWith<_$TermAndConditionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}

Data _$DataFromJson(Map<String, dynamic> json) {
  return _Data.fromJson(json);
}

/// @nodoc
mixin _$Data {
  List<TermsItem>? get items => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataCopyWith<Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res, Data>;
  @useResult
  $Res call({List<TermsItem>? items, int? count});
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
    Object? items = freezed,
    Object? count = freezed,
  }) {
    return _then(_value.copyWith(
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TermsItem>?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataImplCopyWith<$Res> implements $DataCopyWith<$Res> {
  factory _$$DataImplCopyWith(
          _$DataImpl value, $Res Function(_$DataImpl) then) =
      __$$DataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<TermsItem>? items, int? count});
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
    Object? items = freezed,
    Object? count = freezed,
  }) {
    return _then(_$DataImpl(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<TermsItem>?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataImpl implements _Data {
  const _$DataImpl({final List<TermsItem>? items, this.count}) : _items = items;

  factory _$DataImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataImplFromJson(json);

  final List<TermsItem>? _items;
  @override
  List<TermsItem>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? count;

  @override
  String toString() {
    return 'Data(items: $items, count: $count)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), count);

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
  const factory _Data({final List<TermsItem>? items, final int? count}) =
      _$DataImpl;

  factory _Data.fromJson(Map<String, dynamic> json) = _$DataImpl.fromJson;

  @override
  List<TermsItem>? get items;
  @override
  int? get count;
  @override
  @JsonKey(ignore: true)
  _$$DataImplCopyWith<_$DataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TermsItem _$TermsItemFromJson(Map<String, dynamic> json) {
  return _TermsItem.fromJson(json);
}

/// @nodoc
mixin _$TermsItem {
  int? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TermsItemCopyWith<TermsItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TermsItemCopyWith<$Res> {
  factory $TermsItemCopyWith(TermsItem value, $Res Function(TermsItem) then) =
      _$TermsItemCopyWithImpl<$Res, TermsItem>;
  @useResult
  $Res call({int? id, String? title, String? content});
}

/// @nodoc
class _$TermsItemCopyWithImpl<$Res, $Val extends TermsItem>
    implements $TermsItemCopyWith<$Res> {
  _$TermsItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? content = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TermsItemImplCopyWith<$Res>
    implements $TermsItemCopyWith<$Res> {
  factory _$$TermsItemImplCopyWith(
          _$TermsItemImpl value, $Res Function(_$TermsItemImpl) then) =
      __$$TermsItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? title, String? content});
}

/// @nodoc
class __$$TermsItemImplCopyWithImpl<$Res>
    extends _$TermsItemCopyWithImpl<$Res, _$TermsItemImpl>
    implements _$$TermsItemImplCopyWith<$Res> {
  __$$TermsItemImplCopyWithImpl(
      _$TermsItemImpl _value, $Res Function(_$TermsItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? content = freezed,
  }) {
    return _then(_$TermsItemImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TermsItemImpl implements _TermsItem {
  const _$TermsItemImpl({this.id, this.title, this.content});

  factory _$TermsItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$TermsItemImplFromJson(json);

  @override
  final int? id;
  @override
  final String? title;
  @override
  final String? content;

  @override
  String toString() {
    return 'TermsItem(id: $id, title: $title, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TermsItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TermsItemImplCopyWith<_$TermsItemImpl> get copyWith =>
      __$$TermsItemImplCopyWithImpl<_$TermsItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TermsItemImplToJson(
      this,
    );
  }
}

abstract class _TermsItem implements TermsItem {
  const factory _TermsItem(
      {final int? id,
      final String? title,
      final String? content}) = _$TermsItemImpl;

  factory _TermsItem.fromJson(Map<String, dynamic> json) =
      _$TermsItemImpl.fromJson;

  @override
  int? get id;
  @override
  String? get title;
  @override
  String? get content;
  @override
  @JsonKey(ignore: true)
  _$$TermsItemImplCopyWith<_$TermsItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Status _$StatusFromJson(Map<String, dynamic> json) {
  return _Status.fromJson(json);
}

/// @nodoc
mixin _$Status {
  String? get type => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StatusCopyWith<Status> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StatusCopyWith<$Res> {
  factory $StatusCopyWith(Status value, $Res Function(Status) then) =
      _$StatusCopyWithImpl<$Res, Status>;
  @useResult
  $Res call({String? type, String? message});
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
    Object? type = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
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
  $Res call({String? type, String? message});
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
    Object? type = freezed,
    Object? message = freezed,
  }) {
    return _then(_$StatusImpl(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StatusImpl implements _Status {
  const _$StatusImpl({this.type, this.message});

  factory _$StatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$StatusImplFromJson(json);

  @override
  final String? type;
  @override
  final String? message;

  @override
  String toString() {
    return 'Status(type: $type, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StatusImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, message);

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
  const factory _Status({final String? type, final String? message}) =
      _$StatusImpl;

  factory _Status.fromJson(Map<String, dynamic> json) = _$StatusImpl.fromJson;

  @override
  String? get type;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$StatusImplCopyWith<_$StatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
