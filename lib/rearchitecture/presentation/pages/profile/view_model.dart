import 'package:aizuchi_app/rearchitecture/repositiory/firestore.dart';
import 'package:aizuchi_app/rearchitecture/presentation/pages/profile/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.g.dart';

@riverpod
class ProfilePageViewModel extends _$ProfilePageViewModel {
  FirestoreRepository get userInfoRepo =>
      ref.read(firestoreRepositoryProvider.notifier);

  @override
  Future<ProfilePageState> build() async =>
      ProfilePageState(userInfo: await userInfoRepo.getUser());
}


// MEMO: 
// 1. 初期化時 プロバイダーが初めて参照されたときに build メソッドが呼び出されます。これは、プロバイダーが初めて必要とされたときに初期化されるためです。
// 2. 依存関係の変更時　プロバイダーが依存している他のプロバイダーやデータが変更された場合にも build メソッドが再度呼び出されます。例えば、userDataRepoProvider が変更された場合、ProfilePageViewModel の build メソッドも再評価されます。
// 3. 明示的な再構築要求時