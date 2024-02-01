import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hyper_chat/chat_class.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const MyHomePage(title: 'Flutter SendBird Chat'),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  OpenChannel? openChannel;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initSendbird()
        .then(
          (value) => {print("Success")},
        )
        .catchError((err) => {print(err.toString)});
  }
      final chat = Chat('BC823AD1-FBEA-4F08-8F41-CF0D9D280FBF',
        'sendbird_desk_agent_id_eecfb22c-db6b-4da0-b7eb-ab0ebe70fa2a');

  Future<void> initSendbird() async {


    await chat.initialize();

    await chat.join(
        'sendbird_open_channel_14092_bf4075fbb8f12dc0df3ccc5c653f027186ac9211');

    await chat.send('test message');
    chat.onMessageReceived((messagechannel, message) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: CustomAppBar(),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
      reverse: true,
      itemCount: messageList.length,
      itemBuilder: (context, index) {
        var message = messageList[index];
        return ListTile(
          title: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    ),
            ),
           Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.black,
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.white,
                size: 3.h,
              )),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                  color: Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Color(0xFF3A3A3A))),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: '메세지 보내기',
                        hintStyle: TextStyle(
                          color: Color(0XFF666666),
                        ),
                        border: InputBorder.none, // Remove the default border
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Color(0xFF3A3A3A),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_upward,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        chat.send(messageController.text);
                        messageController.clear();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )
          ],
        ),
      ),
    );
  }

  void sendMessage(String message) {
    openChannel?.sendUserMessage(UserMessageCreateParams(message: message));
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.w,
        horizontal: 2.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 4.h,
            ),
            color: Colors.white,
          ),
          Text(
            "강남스팟",
            style: TextStyle(
              color: Colors.white,
              fontSize: 3.h,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

// class MessageListView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// class ChatInput extends StatelessWidget {
//   final Function(String) onSendMessage;
  
  

//   ChatInput({required this.onSendMessage});

//   TextEditingController messageController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

class MyOpenChannelHandler extends OpenChannelHandler {
  final Function(UserMessage) onCustomMessageReceived;

  MyOpenChannelHandler({required this.onCustomMessageReceived});

  @override
  void onMessageReceived(BaseChannel channel, BaseMessage message) {
    if (message is UserMessage) {}
  }
}

List<String> messageList = [];
