import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GEMINI_API_KEY', obfuscate: true)
  static String geminiKey = _Env.geminiKey;
  @EnviedField(varName: 'CHATGPT_API_KEY', obfuscate: true)
  static String gptKey = _Env.gptKey;
}
