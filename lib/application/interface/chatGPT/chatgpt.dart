import 'package:aizuchi_app/domain/models/chatgptmessage.dart';

abstract class ChatGPTInterface {
  Future<String> sendMessage(List<ChatGPTMessage> value);
}
