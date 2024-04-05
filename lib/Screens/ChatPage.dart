import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini_bot/flutter_gemini_bot.dart';
import 'package:flutter_gemini_bot/models/chat_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatModel> chatList = []; // Your list of ChatModel objects
  String apiKey = dotenv.env["GaminiAPI"].toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Chat Bot"),
      ),
      body: FlutterGeminiChat(
        chatContext: 'you are a frontend app developer',
        chatList: chatList,
        apiKey: apiKey,
        botChatBubbleColor: Colors.amber,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
