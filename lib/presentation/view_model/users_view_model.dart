import 'package:aizuchi_app/domain/domain_module.dart';
import 'package:aizuchi_app/domain/entity/enums/platform.dart';
import 'package:aizuchi_app/domain/entity/enums/sex.dart';
import 'package:aizuchi_app/domain/usecases/app_usecase.dart';
import 'package:aizuchi_app/domain/usecases/users_usecase.dart';
import 'package:aizuchi_app/infrastructure/utils/handle_firebase_auth_exception.dart';
import 'package:aizuchi_app/presentation/router/router.dart';
import 'package:aizuchi_app/presentation/state/app_state.dart';
import 'package:aizuchi_app/presentation/state/user_state.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userViewModelProvider = Provider<UserViewModel>(
  (ref) => UserViewModel(
    ref,
    ref.read(usersNotifierProvider.notifier),
    ref.read(usersUsecaseProvider),
    ref.read(appUsecaseProvider),
  ),
);

class UserViewModel {
  final Ref ref;
  final UsersNotifier usersNotifier;
  final UsersUsecase usersUsecase;
  final AppUsecase appUsecase;

  UserViewModel(
    this.ref,
    this.usersNotifier,
    this.usersUsecase,
    this.appUsecase,
  );

  Future<void> signUpWith({
    required PlatformType platform,
    required Function onSuccess,
  }) async {
    try {
      await usersNotifier.signUpWith(platform);
    } on FirebaseAuthException catch (e) {
      ref.read(errorProvider.notifier).state = handleFirebaseAuthException(e);
      return;
    } on Exception {
      ref.read(errorProvider.notifier).state = 'エラーが発生しました。もう一度お試しください。';
      return;
    }
    onSuccess();
  }

  Future<void> signInWith({
    required PlatformType platform,
    required Function onSuccess,
  }) async {
    try {
      await usersNotifier.signInWith(platform);
    } on FirebaseAuthException catch (e) {
      ref.read(errorProvider.notifier).state = handleFirebaseAuthException(e);
      return;
    } on Exception {
      ref.read(errorProvider.notifier).state = 'エラーが発生しました。もう一度お試しください。';
      return;
    }
    onSuccess();
  }

  Future<void> signOut() async {
    usersNotifier.signOut();
  }

  Future<void> register(BuildContext context) async {
    await usersNotifier.register();
    await appUsecase.scheduleDailyNotificationAt(22, 00);
    context.router.push(
      const MessageRoute(),
    );
  }

  Future<void> delete() async {
    usersUsecase.delete();
  }

  Future<String?> readEmail() async {
    return await usersUsecase.readEmail();
  }

  Future<void> updateEmail({
    required String email,
    required Function onSuccess,
    required Function onError,
  }) async {
    try {
      await usersUsecase.updateEmail(email);
    } catch (e) {
      ref.read(errorProvider.notifier).state = e.toString();
      onError();
      return;
    }
    onSuccess();
  }

  Future<void> updatePassword({
    required String email,
    required Function onSuccess,
    required Function onError,
  }) async {
    try {
      await usersUsecase.updatePassword(email);
    } catch (e) {
      ref.read(errorProvider.notifier).state = e.toString();
      onError();
      return;
    }
    onSuccess();
  }

  Future<void> updateProfile({
    required String name,
    required SexEnum sex,
    required DateTime birthday,
    required String profession,
    required Function onSuccess,
    required Function onError,
  }) async {
    try {
      await usersUsecase.update(
        name: name,
        sex: sex,
        birthday: birthday,
        profession: profession,
      );
    } catch (e) {
      ref.read(errorProvider.notifier).state = e.toString();
      onError();
      return;
    }
    onSuccess();
  }
}
