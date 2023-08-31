// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appuser.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AppUser _$AppUserFromJson(Map<String, dynamic> json) {
  return _AppUser.fromJson(json);
}

/// @nodoc
mixin _$AppUser {
// ユーザー入力情報
  String? get name => throw _privateConstructorUsedError;
  int? get sex => throw _privateConstructorUsedError;
  DateTime? get birhtDay => throw _privateConstructorUsedError; // 課金状況
  String? get id => throw _privateConstructorUsedError;
  bool? get billing => throw _privateConstructorUsedError; // ログ
  int? get activeDay => throw _privateConstructorUsedError;
  DateTime? get registerDay => throw _privateConstructorUsedError;
  int? get wordIndex => throw _privateConstructorUsedError; // 指定時刻
  DateTime? get timer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AppUserCopyWith<AppUser> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppUserCopyWith<$Res> {
  factory $AppUserCopyWith(AppUser value, $Res Function(AppUser) then) =
      _$AppUserCopyWithImpl<$Res, AppUser>;
  @useResult
  $Res call(
      {String? name,
      int? sex,
      DateTime? birhtDay,
      String? id,
      bool? billing,
      int? activeDay,
      DateTime? registerDay,
      int? wordIndex,
      DateTime? timer});
}

/// @nodoc
class _$AppUserCopyWithImpl<$Res, $Val extends AppUser>
    implements $AppUserCopyWith<$Res> {
  _$AppUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? sex = freezed,
    Object? birhtDay = freezed,
    Object? id = freezed,
    Object? billing = freezed,
    Object? activeDay = freezed,
    Object? registerDay = freezed,
    Object? wordIndex = freezed,
    Object? timer = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      sex: freezed == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as int?,
      birhtDay: freezed == birhtDay
          ? _value.birhtDay
          : birhtDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      billing: freezed == billing
          ? _value.billing
          : billing // ignore: cast_nullable_to_non_nullable
              as bool?,
      activeDay: freezed == activeDay
          ? _value.activeDay
          : activeDay // ignore: cast_nullable_to_non_nullable
              as int?,
      registerDay: freezed == registerDay
          ? _value.registerDay
          : registerDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      wordIndex: freezed == wordIndex
          ? _value.wordIndex
          : wordIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      timer: freezed == timer
          ? _value.timer
          : timer // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppUserCopyWith<$Res> implements $AppUserCopyWith<$Res> {
  factory _$$_AppUserCopyWith(
          _$_AppUser value, $Res Function(_$_AppUser) then) =
      __$$_AppUserCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      int? sex,
      DateTime? birhtDay,
      String? id,
      bool? billing,
      int? activeDay,
      DateTime? registerDay,
      int? wordIndex,
      DateTime? timer});
}

/// @nodoc
class __$$_AppUserCopyWithImpl<$Res>
    extends _$AppUserCopyWithImpl<$Res, _$_AppUser>
    implements _$$_AppUserCopyWith<$Res> {
  __$$_AppUserCopyWithImpl(_$_AppUser _value, $Res Function(_$_AppUser) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? sex = freezed,
    Object? birhtDay = freezed,
    Object? id = freezed,
    Object? billing = freezed,
    Object? activeDay = freezed,
    Object? registerDay = freezed,
    Object? wordIndex = freezed,
    Object? timer = freezed,
  }) {
    return _then(_$_AppUser(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      sex: freezed == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as int?,
      birhtDay: freezed == birhtDay
          ? _value.birhtDay
          : birhtDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      billing: freezed == billing
          ? _value.billing
          : billing // ignore: cast_nullable_to_non_nullable
              as bool?,
      activeDay: freezed == activeDay
          ? _value.activeDay
          : activeDay // ignore: cast_nullable_to_non_nullable
              as int?,
      registerDay: freezed == registerDay
          ? _value.registerDay
          : registerDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      wordIndex: freezed == wordIndex
          ? _value.wordIndex
          : wordIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      timer: freezed == timer
          ? _value.timer
          : timer // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppUser implements _AppUser {
  const _$_AppUser(
      {required this.name,
      required this.sex,
      required this.birhtDay,
      required this.id,
      required this.billing,
      required this.activeDay,
      required this.registerDay,
      required this.wordIndex,
      required this.timer});

  factory _$_AppUser.fromJson(Map<String, dynamic> json) =>
      _$$_AppUserFromJson(json);

// ユーザー入力情報
  @override
  final String? name;
  @override
  final int? sex;
  @override
  final DateTime? birhtDay;
// 課金状況
  @override
  final String? id;
  @override
  final bool? billing;
// ログ
  @override
  final int? activeDay;
  @override
  final DateTime? registerDay;
  @override
  final int? wordIndex;
// 指定時刻
  @override
  final DateTime? timer;

  @override
  String toString() {
    return 'AppUser(name: $name, sex: $sex, birhtDay: $birhtDay, id: $id, billing: $billing, activeDay: $activeDay, registerDay: $registerDay, wordIndex: $wordIndex, timer: $timer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppUser &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.birhtDay, birhtDay) ||
                other.birhtDay == birhtDay) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.billing, billing) || other.billing == billing) &&
            (identical(other.activeDay, activeDay) ||
                other.activeDay == activeDay) &&
            (identical(other.registerDay, registerDay) ||
                other.registerDay == registerDay) &&
            (identical(other.wordIndex, wordIndex) ||
                other.wordIndex == wordIndex) &&
            (identical(other.timer, timer) || other.timer == timer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, sex, birhtDay, id, billing,
      activeDay, registerDay, wordIndex, timer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      __$$_AppUserCopyWithImpl<_$_AppUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AppUserToJson(
      this,
    );
  }
}

abstract class _AppUser implements AppUser {
  const factory _AppUser(
      {required final String? name,
      required final int? sex,
      required final DateTime? birhtDay,
      required final String? id,
      required final bool? billing,
      required final int? activeDay,
      required final DateTime? registerDay,
      required final int? wordIndex,
      required final DateTime? timer}) = _$_AppUser;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$_AppUser.fromJson;

  @override // ユーザー入力情報
  String? get name;
  @override
  int? get sex;
  @override
  DateTime? get birhtDay;
  @override // 課金状況
  String? get id;
  @override
  bool? get billing;
  @override // ログ
  int? get activeDay;
  @override
  DateTime? get registerDay;
  @override
  int? get wordIndex;
  @override // 指定時刻
  DateTime? get timer;
  @override
  @JsonKey(ignore: true)
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      throw _privateConstructorUsedError;
}
