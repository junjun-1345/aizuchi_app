import 'package:aizuchi_app/domain/entity/enums/update.dart';

abstract class RemoteConfigRepository {
  Future<void> initializeFRC();
  Future<UpdateRequestType> updateRequest(String? cancelledUpdateDateTime);
}
