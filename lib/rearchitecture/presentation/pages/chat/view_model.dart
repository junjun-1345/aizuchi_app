import 'package:aizuchi_app/rearchitecture/domain/enums/message.dart';
import 'package:aizuchi_app/rearchitecture/presentation/pages/chat/state.dart';
import 'package:aizuchi_app/rearchitecture/repo/message/repository.dart';
import 'package:aizuchi_app/rearchitecture/repo/user_data/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.g.dart';

@riverpod
class ChatPageViewModel extends _$ChatPageViewModel {
  UserDataRepo get userInfoRepo => ref.read(userDataRepoProvider.notifier);
  MessageRepo get messageRepo => ref.read(messageRepoProvider.notifier);

  @override
  Future<ChatPageState> build() async => ChatPageState(
        userInfo: await userInfoRepo.getCurrentUserData(),
        message: await messageRepo.getMessages(),
      );

  Future<void> sendMessage(String message, MessageType type) async {
    state = const AsyncValue.loading(); // 非同期操作の開始を示す
    try {
      await messageRepo.sendMessage(message, type);
      final newMessages = await messageRepo.getMessages();
      state = AsyncValue.data(state.value!.copyWith(message: newMessages));
    } catch (e, _) {
      state = AsyncValue.error(e, _); // エラーが発生した場合
    }
  }
}
