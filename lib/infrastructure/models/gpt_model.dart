import 'package:aizuchi_app/infrastructure/enums/gpt_model.dart';
import 'package:aizuchi_app/infrastructure/models/gpt_message.dart';

class GptContent {
  final GptModel gptModel;
  final List<GptMessage> messages;

  GptContent({
    required this.gptModel,
    required this.messages,
  });

  Map<String, dynamic> toJson() => {
        'model': GptRoleExtension.roleValues[gptModel],
        'messages': messages.map((e) => e.toJson()).toList(),
      };

  factory GptContent.fromJson(Map<String, dynamic> json) => GptContent(
        gptModel: GptRoleExtension.from(json['gptModel']),
        messages: List<GptMessage>.from(
            json['messages'].map((x) => GptMessage.fromJson(x))),
      );
}
