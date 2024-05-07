import 'package:aizuchi_app/domain/entity/enums/update.dart';
import 'package:aizuchi_app/infrastructure/enums/remote_config_key.dart';

abstract class RemoteConfigRepository {
  Future<void> initializeFRC();
  Future<UpdateRequestType> updateRequest(String? cancelledUpdateDateTime);
  Future<T?> fetch<T>(RemoteConfigKey key);
}
