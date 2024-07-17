import 'package:aizuchi_app/rearchitecture/domain/user_data/entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class ProfilePageState with _$ProfilePageState {
  const factory ProfilePageState({
    required UserData userInfo,
  }) = _ProfilePageState;
}
