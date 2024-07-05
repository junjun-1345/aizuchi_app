import 'package:aizuchi_app/rearchitecture/feature/profile/state.dart';
import 'package:aizuchi_app/rearchitecture/repo/user_data/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.g.dart';

@riverpod
class ProfilePageViewModel extends _$ProfilePageViewModel {
  UserDataRepo get userInfoRepo => ref.read(userDataRepoProvider.notifier);

  @override
  Future<ProfilePageState> build() async =>
      ProfilePageState(userInfo: await userInfoRepo.getCurrentUserData());
}
