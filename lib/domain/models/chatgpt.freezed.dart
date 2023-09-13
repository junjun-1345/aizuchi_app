// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chatgpt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Chatgpt _$ChatgptFromJson(Map<String, dynamic> json) {
  return _Chatgpt.fromJson(json);
}

/// @nodoc
mixin _$Chatgpt {
  String get model => throw _privateConstructorUsedError;
  List<ChatGPTMessage> get messages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatgptCopyWith<Chatgpt> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatgptCopyWith<$Res> {
  factory $ChatgptCopyWith(Chatgpt value, $Res Function(Chatgpt) then) =
      _$ChatgptCopyWithImpl<$Res, Chatgpt>;
  @useResult
  $Res call({String model, List<ChatGPTMessage> messages});
}

/// @nodoc
class _$ChatgptCopyWithImpl<$Res, $Val extends Chatgpt>
    implements $ChatgptCopyWith<$Res> {
  _$ChatgptCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
    Object? messages = null,
  }) {
    return _then(_value.copyWith(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatGPTMessage>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatgptCopyWith<$Res> implements $ChatgptCopyWith<$Res> {
  factory _$$_ChatgptCopyWith(
          _$_Chatgpt value, $Res Function(_$_Chatgpt) then) =
      __$$_ChatgptCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String model, List<ChatGPTMessage> messages});
}

/// @nodoc
class __$$_ChatgptCopyWithImpl<$Res>
    extends _$ChatgptCopyWithImpl<$Res, _$_Chatgpt>
    implements _$$_ChatgptCopyWith<$Res> {
  __$$_ChatgptCopyWithImpl(_$_Chatgpt _value, $Res Function(_$_Chatgpt) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? model = null,
    Object? messages = null,
  }) {
    return _then(_$_Chatgpt(
      model: null == model
          ? _value.model
          : model // ignore: cast_nullable_to_non_nullable
              as String,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatGPTMessage>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Chatgpt implements _Chatgpt {
  const _$_Chatgpt(
      {required this.model, required final List<ChatGPTMessage> messages})
      : _messages = messages;

  factory _$_Chatgpt.fromJson(Map<String, dynamic> json) =>
      _$$_ChatgptFromJson(json);

  @override
  final String model;
  final List<ChatGPTMessage> _messages;
  @override
  List<ChatGPTMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  String toString() {
    return 'Chatgpt(model: $model, messages: $messages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Chatgpt &&
            (identical(other.model, model) || other.model == model) &&
            const DeepCollectionEquality().equals(other._messages, _messages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, model, const DeepCollectionEquality().hash(_messages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatgptCopyWith<_$_Chatgpt> get copyWith =>
      __$$_ChatgptCopyWithImpl<_$_Chatgpt>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatgptToJson(
      this,
    );
  }
}

abstract class _Chatgpt implements Chatgpt {
  const factory _Chatgpt(
      {required final String model,
      required final List<ChatGPTMessage> messages}) = _$_Chatgpt;

  factory _Chatgpt.fromJson(Map<String, dynamic> json) = _$_Chatgpt.fromJson;

  @override
  String get model;
  @override
  List<ChatGPTMessage> get messages;
  @override
  @JsonKey(ignore: true)
  _$$_ChatgptCopyWith<_$_Chatgpt> get copyWith =>
      throw _privateConstructorUsedError;
}
