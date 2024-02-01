import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'dart:math';

class MyOpenChannelHandler extends OpenChannelHandler {
  Function handler;

  MyOpenChannelHandler(this.handler);

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    handler(channel, message);
  }
}

class Chat {
  String appId;
  String userId;
  User? user;
  OpenChannel? openChannel;

  Chat(this.appId, this.userId);

  String _generateRandomString() {
    const _allowedChars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final _random = Random();

    return List.generate(128, (index) {
      return _allowedChars[_random.nextInt(_allowedChars.length)];
    }).join();
  }

  initialize() async {
    print("Initializing...");
    SendbirdChat.init(appId: this.appId);

    print("Connecting...");
    user = await SendbirdChat.connect(this.userId);
    print("Conntected...");
  }

  join(String channelUrl) async {
    openChannel = await OpenChannel.getChannel(channelUrl);
    await openChannel?.enter();
   
  }

  send(String message) async {
    if (openChannel == null) {
      throw Exception('Channel is not joined');
    }
    openChannel!.sendUserMessage(UserMessageCreateParams(message: message));
  }

  onMessageReceived(Function handler) {
    SendbirdChat.addChannelHandler(
        _generateRandomString(), MyOpenChannelHandler(handler));
  }
}
