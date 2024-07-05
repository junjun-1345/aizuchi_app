import 'package:aizuchi_app/rearchitecture/domain/user_data/entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// 生成されるdartファイルを記述
part 'state.freezed.dart';

// freezedでコード生成するために「@freezed」を記述
@freezed
class ProfilePageState with _$ProfilePageState {
  // withの後には「_$[class name]」の形式で記述

  // プロパティを指定
  const factory ProfilePageState({
    required UserData userInfo,
  }) = _ProfilePageState;
}
