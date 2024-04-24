import 'package:aizuchi_app/domain/entity/enums/update.dart';

abstract class RemoteConfgUsecase {
  Future<void> congigFRC();
  Future<UpdateRequestType> updateRequest();
}
