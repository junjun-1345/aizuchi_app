import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: 'scripts/env/.env')
abstract class Env {
  @EnviedField(varName: 'OPEN_AI_API_KEY', obfuscate: true)
  static final String key1 = _Env.key1;
}
