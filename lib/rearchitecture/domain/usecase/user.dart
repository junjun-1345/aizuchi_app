import 'package:aizuchi_app/rearchitecture/domain/entity/user/model.dart';
import 'package:aizuchi_app/rearchitecture/repositiory/firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.g.dart';

@riverpod
class UserUseCase extends _$UserUseCase {
  FirestoreRepository get userInfoRepo =>
      ref.read(firestoreRepositoryProvider.notifier);

  @override
  void build() {}

  Future<UserData> getUser() async => userInfoRepo.getUser();
}

// MEMO: 使用法
// ex) 日記の始まりのとき、userDBからdailyKeyを参照し、それに基づいて、userDBとdailyDBを同時に更新するパターンなど。→ usecaseが必要な気がする。じゃあ、viewmodelはどうするのか？→ データの保存に徹する?