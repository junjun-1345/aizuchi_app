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
mixin _$ChatPageState {
  UserData get userInfo => throw _privateConstructorUsedError;
  List<Message> get message => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatPageStateCopyWith<ChatPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatPageStateCopyWith<$Res> {
  factory $ChatPageStateCopyWith(
          ChatPageState value, $Res Function(ChatPageState) then) =
      _$ChatPageStateCopyWithImpl<$Res, ChatPageState>;
  @useResult
  $Res call({UserData userInfo, List<Message> message});

  $UserDataCopyWith<$Res> get userInfo;
}

/// @nodoc
class _$ChatPageStateCopyWithImpl<$Res, $Val extends ChatPageState>
    implements $ChatPageStateCopyWith<$Res> {
  _$ChatPageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userInfo = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      userInfo: null == userInfo
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as UserData,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as List<Message>,
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
abstract class _$$ChatPageStateImplCopyWith<$Res>
    implements $ChatPageStateCopyWith<$Res> {
  factory _$$ChatPageStateImplCopyWith(
          _$ChatPageStateImpl value, $Res Function(_$ChatPageStateImpl) then) =
      __$$ChatPageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UserData userInfo, List<Message> message});

  @override
  $UserDataCopyWith<$Res> get userInfo;
}

/// @nodoc
class __$$ChatPageStateImplCopyWithImpl<$Res>
    extends _$ChatPageStateCopyWithImpl<$Res, _$ChatPageStateImpl>
    implements _$$ChatPageStateImplCopyWith<$Res> {
  __$$ChatPageStateImplCopyWithImpl(
      _$ChatPageStateImpl _value, $Res Function(_$ChatPageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userInfo = null,
    Object? message = null,
  }) {
    return _then(_$ChatPageStateImpl(
      userInfo: null == userInfo
          ? _value.userInfo
          : userInfo // ignore: cast_nullable_to_non_nullable
              as UserData,
      message: null == message
          ? _value._message
          : message // ignore: cast_nullable_to_non_nullable
              as List<Message>,
    ));
  }
}

/// @nodoc

class _$ChatPageStateImpl implements _ChatPageState {
  const _$ChatPageStateImpl(
      {required this.userInfo, required final List<Message> message})
      : _message = message;

  @override
  final UserData userInfo;
  final List<Message> _message;
  @override
  List<Message> get message {
    if (_message is EqualUnmodifiableListView) return _message;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_message);
  }

  @override
  String toString() {
    return 'ChatPageState(userInfo: $userInfo, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatPageStateImpl &&
            (identical(other.userInfo, userInfo) ||
                other.userInfo == userInfo) &&
            const DeepCollectionEquality().equals(other._message, _message));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, userInfo, const DeepCollectionEquality().hash(_message));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatPageStateImplCopyWith<_$ChatPageStateImpl> get copyWith =>
      __$$ChatPageStateImplCopyWithImpl<_$ChatPageStateImpl>(this, _$identity);
}

abstract class _ChatPageState implements ChatPageState {
  const factory _ChatPageState(
      {required final UserData userInfo,
      required final List<Message> message}) = _$ChatPageStateImpl;

  @override
  UserData get userInfo;
  @override
  List<Message> get message;
  @override
  @JsonKey(ignore: true)
  _$$ChatPageStateImplCopyWith<_$ChatPageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
