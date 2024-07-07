// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return _UserData.fromJson(json);
}

/// @nodoc
mixin _$UserData {
  String get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get activeDay => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get timer => throw _privateConstructorUsedError;
  String? get sex => throw _privateConstructorUsedError;
  String? get charactor => throw _privateConstructorUsedError;
  String? get dailyKey => throw _privateConstructorUsedError;
  String? get profession => throw _privateConstructorUsedError;
  int? get totalMessage => throw _privateConstructorUsedError;
  dynamic get billing => throw _privateConstructorUsedError;
  dynamic get init => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get birthday => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataCopyWith<UserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) then) =
      _$UserDataCopyWithImpl<$Res, UserData>;
  @useResult
  $Res call(
      {String id,
      String? name,
      int? activeDay,
      String? email,
      String? timer,
      String? sex,
      String? charactor,
      String? dailyKey,
      String? profession,
      int? totalMessage,
      dynamic billing,
      dynamic init,
      @TimestampConverter() DateTime? birthday,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res, $Val extends UserData>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? activeDay = freezed,
    Object? email = freezed,
    Object? timer = freezed,
    Object? sex = freezed,
    Object? charactor = freezed,
    Object? dailyKey = freezed,
    Object? profession = freezed,
    Object? totalMessage = freezed,
    Object? billing = freezed,
    Object? init = freezed,
    Object? birthday = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      activeDay: freezed == activeDay
          ? _value.activeDay
          : activeDay // ignore: cast_nullable_to_non_nullable
              as int?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      timer: freezed == timer
          ? _value.timer
          : timer // ignore: cast_nullable_to_non_nullable
              as String?,
      sex: freezed == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String?,
      charactor: freezed == charactor
          ? _value.charactor
          : charactor // ignore: cast_nullable_to_non_nullable
              as String?,
      dailyKey: freezed == dailyKey
          ? _value.dailyKey
          : dailyKey // ignore: cast_nullable_to_non_nullable
              as String?,
      profession: freezed == profession
          ? _value.profession
          : profession // ignore: cast_nullable_to_non_nullable
              as String?,
      totalMessage: freezed == totalMessage
          ? _value.totalMessage
          : totalMessage // ignore: cast_nullable_to_non_nullable
              as int?,
      billing: freezed == billing
          ? _value.billing
          : billing // ignore: cast_nullable_to_non_nullable
              as dynamic,
      init: freezed == init
          ? _value.init
          : init // ignore: cast_nullable_to_non_nullable
              as dynamic,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDataImplCopyWith<$Res>
    implements $UserDataCopyWith<$Res> {
  factory _$$UserDataImplCopyWith(
          _$UserDataImpl value, $Res Function(_$UserDataImpl) then) =
      __$$UserDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? name,
      int? activeDay,
      String? email,
      String? timer,
      String? sex,
      String? charactor,
      String? dailyKey,
      String? profession,
      int? totalMessage,
      dynamic billing,
      dynamic init,
      @TimestampConverter() DateTime? birthday,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$UserDataImplCopyWithImpl<$Res>
    extends _$UserDataCopyWithImpl<$Res, _$UserDataImpl>
    implements _$$UserDataImplCopyWith<$Res> {
  __$$UserDataImplCopyWithImpl(
      _$UserDataImpl _value, $Res Function(_$UserDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? activeDay = freezed,
    Object? email = freezed,
    Object? timer = freezed,
    Object? sex = freezed,
    Object? charactor = freezed,
    Object? dailyKey = freezed,
    Object? profession = freezed,
    Object? totalMessage = freezed,
    Object? billing = freezed,
    Object? init = freezed,
    Object? birthday = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$UserDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      activeDay: freezed == activeDay
          ? _value.activeDay
          : activeDay // ignore: cast_nullable_to_non_nullable
              as int?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      timer: freezed == timer
          ? _value.timer
          : timer // ignore: cast_nullable_to_non_nullable
              as String?,
      sex: freezed == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String?,
      charactor: freezed == charactor
          ? _value.charactor
          : charactor // ignore: cast_nullable_to_non_nullable
              as String?,
      dailyKey: freezed == dailyKey
          ? _value.dailyKey
          : dailyKey // ignore: cast_nullable_to_non_nullable
              as String?,
      profession: freezed == profession
          ? _value.profession
          : profession // ignore: cast_nullable_to_non_nullable
              as String?,
      totalMessage: freezed == totalMessage
          ? _value.totalMessage
          : totalMessage // ignore: cast_nullable_to_non_nullable
              as int?,
      billing: freezed == billing ? _value.billing! : billing,
      init: freezed == init ? _value.init! : init,
      birthday: freezed == birthday
          ? _value.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDataImpl implements _UserData {
  const _$UserDataImpl(
      {required this.id,
      this.name,
      this.activeDay,
      this.email,
      this.timer,
      this.sex,
      this.charactor,
      this.dailyKey,
      this.profession,
      this.totalMessage,
      this.billing = false,
      this.init = false,
      @TimestampConverter() this.birthday,
      @TimestampConverter() this.createdAt});

  factory _$UserDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataImplFromJson(json);

  @override
  final String id;
  @override
  final String? name;
  @override
  final int? activeDay;
  @override
  final String? email;
  @override
  final String? timer;
  @override
  final String? sex;
  @override
  final String? charactor;
  @override
  final String? dailyKey;
  @override
  final String? profession;
  @override
  final int? totalMessage;
  @override
  @JsonKey()
  final dynamic billing;
  @override
  @JsonKey()
  final dynamic init;
  @override
  @TimestampConverter()
  final DateTime? birthday;
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'UserData(id: $id, name: $name, activeDay: $activeDay, email: $email, timer: $timer, sex: $sex, charactor: $charactor, dailyKey: $dailyKey, profession: $profession, totalMessage: $totalMessage, billing: $billing, init: $init, birthday: $birthday, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.activeDay, activeDay) ||
                other.activeDay == activeDay) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.timer, timer) || other.timer == timer) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.charactor, charactor) ||
                other.charactor == charactor) &&
            (identical(other.dailyKey, dailyKey) ||
                other.dailyKey == dailyKey) &&
            (identical(other.profession, profession) ||
                other.profession == profession) &&
            (identical(other.totalMessage, totalMessage) ||
                other.totalMessage == totalMessage) &&
            const DeepCollectionEquality().equals(other.billing, billing) &&
            const DeepCollectionEquality().equals(other.init, init) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      activeDay,
      email,
      timer,
      sex,
      charactor,
      dailyKey,
      profession,
      totalMessage,
      const DeepCollectionEquality().hash(billing),
      const DeepCollectionEquality().hash(init),
      birthday,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      __$$UserDataImplCopyWithImpl<_$UserDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDataImplToJson(
      this,
    );
  }
}

abstract class _UserData implements UserData {
  const factory _UserData(
      {required final String id,
      final String? name,
      final int? activeDay,
      final String? email,
      final String? timer,
      final String? sex,
      final String? charactor,
      final String? dailyKey,
      final String? profession,
      final int? totalMessage,
      final dynamic billing,
      final dynamic init,
      @TimestampConverter() final DateTime? birthday,
      @TimestampConverter() final DateTime? createdAt}) = _$UserDataImpl;

  factory _UserData.fromJson(Map<String, dynamic> json) =
      _$UserDataImpl.fromJson;

  @override
  String get id;
  @override
  String? get name;
  @override
  int? get activeDay;
  @override
  String? get email;
  @override
  String? get timer;
  @override
  String? get sex;
  @override
  String? get charactor;
  @override
  String? get dailyKey;
  @override
  String? get profession;
  @override
  int? get totalMessage;
  @override
  dynamic get billing;
  @override
  dynamic get init;
  @override
  @TimestampConverter()
  DateTime? get birthday;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
