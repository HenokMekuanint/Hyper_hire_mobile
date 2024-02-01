import 'package:hyper_chat/chat_class.dart';
import 'package:test/test.dart';

void main() {
  test("test functionality", () async {
    final chat = Chat('BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF',
        'sendbird_desk_agent_id_eecfb22c-db6b-4da0-b7eb-ab0ebe70fa2a');

    await chat.initialize();
    await chat.join(
        'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211');
    await chat.send('test message');
  });
}
