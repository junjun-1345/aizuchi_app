// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ProfilePageState {
  UserData get userInfo => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProfilePageStateCopyWith<ProfilePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfilePageStateCopyWith<$Res> {
  factory $ProfilePageStateCopyWith(
          ProfilePageState value, $Res Function(ProfilePageState) then) =
      _$ProfilePageStateCopyWithImpl<$Res, ProfilePageState>;
  @useResult
  $Res call({UserData userInfo});

  $UserDataCopyWith<$Res> get userInfo;
}

/// @nodoc
class _$ProfilePageStateCopyWithImpl<$Res, $Val extends ProfilePageState>
    implements $ProfilePageStateCopyWith<$Res> {
  _$ProfilePageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userInfo = null,
  }) {
    return _then(_value.copyWith(
      userInfo: null == userInfo
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as UserData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDataCopyWith<$Res> get userInfo {
    return $UserDataCopyWith<$Res>(_value.userInfo, (value) {
      return _then(_value.copyWith(userInfo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProfilePageStateImplCopyWith<$Res>
    implements $ProfilePageStateCopyWith<$Res> {
  factory _$$ProfilePageStateImplCopyWith(_$ProfilePageStateImpl value,
          $Res Function(_$ProfilePageStateImpl) then) =
      __$$ProfilePageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserData userInfo});

  @override
  $UserDataCopyWith<$Res> get userInfo;
}

/// @nodoc
class __$$ProfilePageStateImplCopyWithImpl<$Res>
    extends _$ProfilePageStateCopyWithImpl<$Res, _$ProfilePageStateImpl>
    implements _$$ProfilePageStateImplCopyWith<$Res> {
  __$$ProfilePageStateImplCopyWithImpl(_$ProfilePageStateImpl _value,
      $Res Function(_$ProfilePageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userInfo = null,
  }) {
    return _then(_$ProfilePageStateImpl(
      userInfo: null == userInfo
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as UserData,
    ));
  }
}

/// @nodoc

class _$ProfilePageStateImpl implements _ProfilePageState {
  const _$ProfilePageStateImpl({required this.userInfo});

  @override
  final UserData userInfo;

  @override
  String toString() {
    return 'ProfilePageState(userInfo: $userInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfilePageStateImpl &&
            (identical(other.userInfo, userInfo) ||
                other.userInfo == userInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfilePageStateImplCopyWith<_$ProfilePageStateImpl> get copyWith =>
      __$$ProfilePageStateImplCopyWithImpl<_$ProfilePageStateImpl>(
          this, _$identity);
}

abstract class _ProfilePageState implements ProfilePageState {
  const factory _ProfilePageState({required final UserData userInfo}) =
      _$ProfilePageStateImpl;

  @override
  UserData get userInfo;
  @override
  @JsonKey(ignore: true)
  _$$ProfilePageStateImplCopyWith<_$ProfilePageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
