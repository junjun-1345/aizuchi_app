import 'package:aizuchi_app/domain/entity/enums/update.dart';

abstract class RemoteConfigRepository {
  Future<void> congigFRC();
  Future<UpdateRequestType> updateRequest(String? cancelledUpdateDateTime);
}
