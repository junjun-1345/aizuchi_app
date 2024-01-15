import 'package:aizuchi_app/domain/interactor/users_interactor.dart';
import 'package:aizuchi_app/domain/usecases/users_usecase.dart';
import 'package:aizuchi_app/infrastructure/data_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userUsecaseProvider = Provider<UsersUseCase>(((ref) {
  return UsersInteractor(ref.watch(usersRepositoryProvider));
}));
