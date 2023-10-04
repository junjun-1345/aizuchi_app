import 'package:aizuchi_app/application/di/infrastructure.dart';
import 'package:aizuchi_app/domain/features/datetime.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dailykey_state.g.dart';

@riverpod
class DailykeyStateNotifier extends _$DailykeyStateNotifier {
  @override
  String build() {
    return CustomDateTime().nowDate();
  }

  // データを変更する関数
  Future<void> initState() async {
    final firestore = ref.watch(firestoreProvider);
    state = await firestore.dailyGetKey();
  }
}
