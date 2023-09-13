import 'package:aizuchi_app/application/di/infrastructure.dart';
import 'package:aizuchi_app/application/state/account.dart';
import 'package:aizuchi_app/application/state/appuser.dart';
import 'package:aizuchi_app/application/state/googleauth.dart';
import 'package:aizuchi_app/application/state/waitng.dart';
import 'package:aizuchi_app/application/usecase/account_usecase.dart';
import 'package:aizuchi_app/application/usecase/message_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountUsecaseProvider = Provider<AccountUsecase>(
  (ref) {
    final auth = ref.watch(authProvider);
    final firestore = ref.watch(firestoreProvider);
    final googleAuth = ref.watch(signedInProvider);
    final appUserState = ref.watch(appUserNotifierProvider);
    final appUserNotifier = ref.read(appUserNotifierProvider.notifier);
    final accountState = ref.read(accountNotifierProvider);
    final accountNotifier = ref.read(accountNotifierProvider.notifier);
    return AccountUsecase(
      auth: auth,
      firestore: firestore,
      googleAuth: googleAuth,
      appUserState: appUserState,
      appUserNotifier: appUserNotifier,
      accountState: accountState,
      accountNotifier: accountNotifier,
    );
  },
);

final messageUsecaseProvider = Provider<MessageUsecase>(
  (ref) {
    final firestore = ref.watch(firestoreProvider);
    final chatGPT = ref.read(chatGPTProvider);
    final waitingNotifier = ref.read(waitngNotifierProvider.notifier);
    return MessageUsecase(
      firestore: firestore,
      chatGPT: chatGPT,
      waitingNotifier: waitingNotifier,
    );
  },
);
