import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dailykey_state.g.dart';

@Riverpod(keepAlive: true)
class DailykeyStateNotifier extends _$DailykeyStateNotifier {
  @override
  String build() {
    return "";
  }

  // データを変更する関数
  void setState(String value) async {
    state = value;
  }
}
