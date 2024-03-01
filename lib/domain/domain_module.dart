import 'package:aizuchi_app/domain/interactor/messages_interactor.dart';
import 'package:aizuchi_app/domain/interactor/users_interactor.dart';
import 'package:aizuchi_app/domain/usecases/messages_usecase.dart';
import 'package:aizuchi_app/domain/usecases/users_usecase.dart';
import 'package:aizuchi_app/infrastructure/data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final usersUsecaseProvider = Provider<UsersUsecase>(
  ((ref) {
    return UsersInteractor(
      ref.watch(userDBRepositoryProvider),
      ref.watch(authRepositoryProvider),
      ref.watch(localDBRepositoryProvider),
    );
  }),
);

final messagesUsecaseProvider = Provider<MessageUsecases>((ref) {
  return MessagesInteractor(
    ref.watch(messageDBRepositoryProvider),
    ref.watch(geminiRepositoryProvider),
    ref.watch(gptRepositoryProvider),
  );
});