import 'package:aizuchi_app/rearchitecture/presentation/pages/profile/state.dart';
import 'package:aizuchi_app/rearchitecture/domain/usecase/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_model.g.dart';

@riverpod
class ProfilePageViewModel extends _$ProfilePageViewModel {
  UserUseCase get userUseCase => ref.read(userUseCaseProvider.notifier);

  @override
  Future<ProfilePageState> build() async =>
      ProfilePageState(userInfo: await userUseCase.getUser());
}


// MEMO: 
// 1. 初期化時 プロバイダーが初めて参照されたときに build メソッドが呼び出されます。これは、プロバイダーが初めて必要とされたときに初期化されるためです。
// 2. 依存関係の変更時　プロバイダーが依存している他のプロバイダーやデータが変更された場合にも build メソッドが再度呼び出されます。例えば、userDataRepoProvider が変更された場合、ProfilePageViewModel の build メソッドも再評価されます。
// 3. 明示的な再構築要求時


// TODO(Rearchitecture): 複数リポジトリを呼び出すパターンはどのように対応するのか?
// ex) 日記の始まりのとき、userDBからdailyKeyを参照し、それに基づいて、userDBとdailyDBを同時に更新するパターンなど。→ usecaseが必要な気がする。じゃあ、viewmodelはどうするのか？→ データの保存に徹する?