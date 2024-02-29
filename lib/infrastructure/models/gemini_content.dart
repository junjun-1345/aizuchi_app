import 'package:aizuchi_app/domain/entity/models/message.dart';
import 'package:aizuchi_app/infrastructure/enums/gemini_role.dart';
import 'package:aizuchi_app/infrastructure/models/gemini_content_part.dart';

class GeminiContent {
  final GeminiRole role;
  final List<GeminiContentParts> parts;

  GeminiContent({
    required this.role,
    required this.parts,
  });

  Map<String, dynamic> toJson() => {
        'role': GeminiRoleExtension.roleValues[role],
        'parts': [parts[0].toJson()],
      };

  factory GeminiContent.fromJson(Map<String, dynamic> json) => GeminiContent(
        role: json['role'],
        parts: [GeminiContentParts.fromJson(json['parts'])],
      );

  static GeminiContent fromEntity(MessageEntity entity) => GeminiContent(
        role: convertToGeminiRole(entity.type),
        parts: [GeminiContentParts(text: entity.content)],
      );
}
