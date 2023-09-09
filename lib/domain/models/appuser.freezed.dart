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
// ユーザー情報
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get sex => throw _privateConstructorUsedError;
  String get birhtDay => throw _privateConstructorUsedError;
  bool get init => throw _privateConstructorUsedError; // 課金状況
  bool get billing => throw _privateConstructorUsedError; // ログ
  int get activeDay => throw _privateConstructorUsedError;
  String get registerDay => throw _privateConstructorUsedError;
  int get wordIndex => throw _privateConstructorUsedError; // 指定時刻
  String get timer => throw _privateConstructorUsedError;

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
      {String id,
      String name,
      int sex,
      String birhtDay,
      bool init,
      bool billing,
      int activeDay,
      String registerDay,
      int wordIndex,
      String timer});
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
    Object? id = null,
    Object? name = null,
    Object? sex = null,
    Object? birhtDay = null,
    Object? init = null,
    Object? billing = null,
    Object? activeDay = null,
    Object? registerDay = null,
    Object? wordIndex = null,
    Object? timer = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sex: null == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as int,
      birhtDay: null == birhtDay
          ? _value.birhtDay
          : birhtDay // ignore: cast_nullable_to_non_nullable
              as String,
      init: null == init
          ? _value.init
          : init // ignore: cast_nullable_to_non_nullable
              as bool,
      billing: null == billing
          ? _value.billing
          : billing // ignore: cast_nullable_to_non_nullable
              as bool,
      activeDay: null == activeDay
          ? _value.activeDay
          : activeDay // ignore: cast_nullable_to_non_nullable
              as int,
      registerDay: null == registerDay
          ? _value.registerDay
          : registerDay // ignore: cast_nullable_to_non_nullable
              as String,
      wordIndex: null == wordIndex
          ? _value.wordIndex
          : wordIndex // ignore: cast_nullable_to_non_nullable
              as int,
      timer: null == timer
          ? _value.timer
          : timer // ignore: cast_nullable_to_non_nullable
              as String,
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
      {String id,
      String name,
      int sex,
      String birhtDay,
      bool init,
      bool billing,
      int activeDay,
      String registerDay,
      int wordIndex,
      String timer});
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
    Object? id = null,
    Object? name = null,
    Object? sex = null,
    Object? birhtDay = null,
    Object? init = null,
    Object? billing = null,
    Object? activeDay = null,
    Object? registerDay = null,
    Object? wordIndex = null,
    Object? timer = null,
  }) {
    return _then(_$_AppUser(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      sex: null == sex
          ? _value.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as int,
      birhtDay: null == birhtDay
          ? _value.birhtDay
          : birhtDay // ignore: cast_nullable_to_non_nullable
              as String,
      init: null == init
          ? _value.init
          : init // ignore: cast_nullable_to_non_nullable
              as bool,
      billing: null == billing
          ? _value.billing
          : billing // ignore: cast_nullable_to_non_nullable
              as bool,
      activeDay: null == activeDay
          ? _value.activeDay
          : activeDay // ignore: cast_nullable_to_non_nullable
              as int,
      registerDay: null == registerDay
          ? _value.registerDay
          : registerDay // ignore: cast_nullable_to_non_nullable
              as String,
      wordIndex: null == wordIndex
          ? _value.wordIndex
          : wordIndex // ignore: cast_nullable_to_non_nullable
              as int,
      timer: null == timer
          ? _value.timer
          : timer // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AppUser implements _AppUser {
  const _$_AppUser(
      {this.id = '',
      this.name = '',
      this.sex = 0,
      this.birhtDay = '',
      this.init = false,
      this.billing = false,
      this.activeDay = 0,
      this.registerDay = '',
      this.wordIndex = 0,
      this.timer = ''});

  factory _$_AppUser.fromJson(Map<String, dynamic> json) =>
      _$$_AppUserFromJson(json);

// ユーザー情報
  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int sex;
  @override
  @JsonKey()
  final String birhtDay;
  @override
  @JsonKey()
  final bool init;
// 課金状況
  @override
  @JsonKey()
  final bool billing;
// ログ
  @override
  @JsonKey()
  final int activeDay;
  @override
  @JsonKey()
  final String registerDay;
  @override
  @JsonKey()
  final int wordIndex;
// 指定時刻
  @override
  @JsonKey()
  final String timer;

  @override
  String toString() {
    return 'AppUser(id: $id, name: $name, sex: $sex, birhtDay: $birhtDay, init: $init, billing: $billing, activeDay: $activeDay, registerDay: $registerDay, wordIndex: $wordIndex, timer: $timer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.birhtDay, birhtDay) ||
                other.birhtDay == birhtDay) &&
            (identical(other.init, init) || other.init == init) &&
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
  int get hashCode => Object.hash(runtimeType, id, name, sex, birhtDay, init,
      billing, activeDay, registerDay, wordIndex, timer);

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
      {final String id,
      final String name,
      final int sex,
      final String birhtDay,
      final bool init,
      final bool billing,
      final int activeDay,
      final String registerDay,
      final int wordIndex,
      final String timer}) = _$_AppUser;

  factory _AppUser.fromJson(Map<String, dynamic> json) = _$_AppUser.fromJson;

  @override // ユーザー情報
  String get id;
  @override
  String get name;
  @override
  int get sex;
  @override
  String get birhtDay;
  @override
  bool get init;
  @override // 課金状況
  bool get billing;
  @override // ログ
  int get activeDay;
  @override
  String get registerDay;
  @override
  int get wordIndex;
  @override // 指定時刻
  String get timer;
  @override
  @JsonKey(ignore: true)
  _$$_AppUserCopyWith<_$_AppUser> get copyWith =>
      throw _privateConstructorUsedError;
}
