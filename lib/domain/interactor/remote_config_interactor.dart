import 'package:aizuchi_app/domain/entity/enums/shared_preferences_key.dart';
import 'package:aizuchi_app/domain/entity/enums/update.dart';
import 'package:aizuchi_app/domain/repositories/remote_config.dart';
import 'package:aizuchi_app/domain/repositories/shared_preferences_repository.dart';
import 'package:aizuchi_app/domain/usecases/remote_config_usecase.dart';

class RemoteConfigInteractor implements RemoteConfgUsecase {
  final RemoteConfigRepository remoteConfigRepository;
  final SharedPreferencesRepository sharedPreferencesRepository;

  RemoteConfigInteractor(
      this.remoteConfigRepository, this.sharedPreferencesRepository);
  @override
  Future<UpdateRequestType> updateRequest() async {
    final cancelledUpdateDateTime = await sharedPreferencesRepository
        .fetch<String>(SharedPreferencesKey.cancelledUpdateDateTime);
    return await remoteConfigRepository.updateRequest(cancelledUpdateDateTime);
  }

  @override
  Future<void> congigFRC() async {
    await remoteConfigRepository.congigFRC();
  }
}
