import 'package:aizuchi_app/domain/interactor/app_interactor.dart';
import 'package:aizuchi_app/domain/interactor/calendar_interactor.dart';
import 'package:aizuchi_app/domain/interactor/daily_interactor.dart';
import 'package:aizuchi_app/domain/interactor/messages_interactor.dart';
import 'package:aizuchi_app/domain/interactor/users_interactor.dart';
import 'package:aizuchi_app/domain/usecases/app_usecase.dart';
import 'package:aizuchi_app/domain/usecases/calendar_usecase.dart';
import 'package:aizuchi_app/domain/usecases/daily_usecase.dart';
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

final messagesUsecaseProvider = Provider<MessageUsecase>((ref) {
  return MessagesInteractor(
    ref.watch(messageDBRepositoryProvider),
    ref.watch(geminiRepositoryProvider),
    ref.watch(gptRepositoryProvider),
  );
});

final dailyUsecaseProvider = Provider<DailyUsecase>((ref) {
  return DailyInteractor(
    ref.watch(dailyDBRepositoryProvider),
    ref.watch(userDBRepositoryProvider),
  );
});

final calendarUsecaseProvider = Provider<CalendarUsecase>((ref) {
  return CalendarInteractor();
});

final appUsecaseProvider = Provider<AppUsecase>((ref) {
  return AppInteractor(
    ref.watch(userDBRepositoryProvider),
    ref.watch(purchasesFlutterRepositoryProvider),
    ref.watch(remoteConfigRepositoryProvider),
    ref.watch(sharedPreferencesRepositoryProvider),
    ref.watch(localNotificationRepositoryProvider),
  );
});
