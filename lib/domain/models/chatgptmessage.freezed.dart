// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chatgptmessage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatGPTMessage _$ChatGPTMessageFromJson(Map<String, dynamic> json) {
  return _ChatGPTMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatGPTMessage {
  String get role => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatGPTMessageCopyWith<ChatGPTMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatGPTMessageCopyWith<$Res> {
  factory $ChatGPTMessageCopyWith(
          ChatGPTMessage value, $Res Function(ChatGPTMessage) then) =
      _$ChatGPTMessageCopyWithImpl<$Res, ChatGPTMessage>;
  @useResult
  $Res call({String role, String content});
}

/// @nodoc
class _$ChatGPTMessageCopyWithImpl<$Res, $Val extends ChatGPTMessage>
    implements $ChatGPTMessageCopyWith<$Res> {
  _$ChatGPTMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? role = null,
    Object? content = null,
  }) {
    return _then(_value.copyWith(
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatGPTMessageCopyWith<$Res>
    implements $ChatGPTMessageCopyWith<$Res> {
  factory _$$_ChatGPTMessageCopyWith(
          _$_ChatGPTMessage value, $Res Function(_$_ChatGPTMessage) then) =
      __$$_ChatGPTMessageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String role, String content});
}

/// @nodoc
class __$$_ChatGPTMessageCopyWithImpl<$Res>
    extends _$ChatGPTMessageCopyWithImpl<$Res, _$_ChatGPTMessage>
    implements _$$_ChatGPTMessageCopyWith<$Res> {
  __$$_ChatGPTMessageCopyWithImpl(
      _$_ChatGPTMessage _value, $Res Function(_$_ChatGPTMessage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? role = null,
    Object? content = null,
  }) {
    return _then(_$_ChatGPTMessage(
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatGPTMessage implements _ChatGPTMessage {
  const _$_ChatGPTMessage({required this.role, required this.content});

  factory _$_ChatGPTMessage.fromJson(Map<String, dynamic> json) =>
      _$$_ChatGPTMessageFromJson(json);

  @override
  final String role;
  @override
  final String content;

  @override
  String toString() {
    return 'ChatGPTMessage(role: $role, content: $content)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatGPTMessage &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, role, content);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatGPTMessageCopyWith<_$_ChatGPTMessage> get copyWith =>
      __$$_ChatGPTMessageCopyWithImpl<_$_ChatGPTMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatGPTMessageToJson(
      this,
    );
  }
}

abstract class _ChatGPTMessage implements ChatGPTMessage {
  const factory _ChatGPTMessage(
      {required final String role,
      required final String content}) = _$_ChatGPTMessage;

  factory _ChatGPTMessage.fromJson(Map<String, dynamic> json) =
      _$_ChatGPTMessage.fromJson;

  @override
  String get role;
  @override
  String get content;
  @override
  @JsonKey(ignore: true)
  _$$_ChatGPTMessageCopyWith<_$_ChatGPTMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
