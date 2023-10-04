import 'package:aizuchi_app/application/di/infrastructure.dart';
import 'package:aizuchi_app/application/state/account_state.dart';
import 'package:aizuchi_app/application/state/appuser_state.dart';
import 'package:aizuchi_app/application/state/googleauth_state.dart';
import 'package:aizuchi_app/application/state/waitng_state.dart';
import 'package:aizuchi_app/application/usecase/account_usecase.dart';
import 'package:aizuchi_app/application/usecase/calender_usecase.dart';
import 'package:aizuchi_app/application/usecase/log_usecase.dart';
import 'package:aizuchi_app/application/usecase/message_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountUsecaseProvider = Provider<AccountUsecase>(
  (ref) {
    final auth = ref.watch(authProvider);
    final firestore = ref.watch(firestoreProvider);
    final googleAuth = ref.watch(signedInProvider);
    final appUserState = ref.watch(appUserStateNotifierProvider);
    final accountState = ref.read(accountStateNotifierProvider);
    final accountStateNotifier =
        ref.read(accountStateNotifierProvider.notifier);
    return AccountUsecase(
      auth: auth,
      firestore: firestore,
      googleAuth: googleAuth,
      appUserState: appUserState,
      accountState: accountState,
      accountStateNotifier: accountStateNotifier,
    );
  },
);

final messageUsecaseProvider = Provider<MessageUsecase>(
  (ref) {
    final firestore = ref.watch(firestoreProvider);
    final chatGPT = ref.read(chatGPTProvider);
    final waitingStateNotifier = ref.read(waitngStateNotifierProvider.notifier);
    return MessageUsecase(
      firestore: firestore,
      chatGPT: chatGPT,
      waitingStateNotifier: waitingStateNotifier,
    );
  },
);

final logUsecaseProvider = Provider<LogUsecase>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return LogUsecase(
    firestore: firestore,
  );
});

final calenderUsecaseProvider = Provider<CalenderUsecase>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return CalenderUsecase(
    firestore: firestore,
  );
});
