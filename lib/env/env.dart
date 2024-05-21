import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GEMINI_API_KEY', obfuscate: true)
  static String geminiKey = _Env.geminiKey;
  @EnviedField(varName: 'CHATGPT_API_KEY', obfuscate: true)
  static String gptKey = _Env.gptKey;
  @EnviedField(varName: 'REVENUECAT_DEVELOP_API_KEY', obfuscate: true)
  static String revenucatDevelopApiKey = _Env.revenucatDevelopApiKey;
  @EnviedField(varName: 'REVENUECAT_PROD_API_KEY', obfuscate: true)
  static String revenucatProdApiKey = _Env.revenucatProdApiKey;
  @EnviedField(varName: 'CLAUDE_DEV_API_KEY', obfuscate: true)
  static String claudeDevApiKey = _Env.claudeDevApiKey;
}
