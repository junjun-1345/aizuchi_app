import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum AuthProviderType {
  google,
  facebook,
  twitter,
  apple,
  emailAndPassword,
  phone,
  unknown
}

extension AuthProviderExtension on AuthProviderType {
  // プロバイダIDとAuthProviderTypeのマッピング
  static final providerValues = {
    AuthProviderType.google: "google.com",
    AuthProviderType.facebook: "facebook.com",
    AuthProviderType.twitter: "twitter.com",
    AuthProviderType.apple: "apple.com",
    AuthProviderType.emailAndPassword: "password",
    AuthProviderType.phone: "phone",
    AuthProviderType.unknown: "unknown",
  };

  // プロバイダIDを取得するゲッター
  String? get providerId => providerValues[this];

  // 文字列からAuthProviderへの変換
  static AuthProviderType from(String rawValue) {
    return AuthProviderType.values.firstWhere(
      (e) => e.providerId == rawValue,
      orElse: () => AuthProviderType.unknown,
    );
  }
}

extension AuthProviderTypeExtension on AuthProviderType {
  IconData get icon {
    switch (this) {
      case AuthProviderType.google:
        return FontAwesomeIcons.google;
      case AuthProviderType.facebook:
        return FontAwesomeIcons.facebook;
      case AuthProviderType.twitter:
        return FontAwesomeIcons.twitter;
      case AuthProviderType.apple:
        return FontAwesomeIcons.apple;
      case AuthProviderType.emailAndPassword:
        return Icons.email;
      case AuthProviderType.phone:
        return Icons.phone;
      default:
        return Icons.help_outline;
    }
  }
}
