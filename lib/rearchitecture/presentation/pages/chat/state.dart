import 'package:aizuchi_app/rearchitecture/domain/message/entity.dart';
import 'package:aizuchi_app/rearchitecture/domain/user_data/entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class ChatPageState with _$ChatPageState {
  const factory ChatPageState({
    required UserData userInfo,
    required List<Message> message,
  }) = _ChatPageState;
}
