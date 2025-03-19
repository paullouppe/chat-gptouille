import 'package:flutter/material.dart';
import 'package:flutter_app/screens/pages_navbar.dart';
import 'package:flutter_app/services/requests.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  List<types.Message> _messages = [];
  final _user = const types.User(id: '12345');

  void _handleSendPressed(types.PartialText message) async {
    // Create and add the user's message.
    final userMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, userMessage);
    });

    // Prepare the request payload.
    final requestData = {'user_message': message.text};

    try {
      // Call the API and get a stream of response data.
      Stream<String> responseStream =
          await streamRequest(requestData, 'http://localhost:8080/chat/');

      // This will accumulate the bot's reply.
      String accumulatedResponse = '';
      // Listen to the stream and update the bot message as data arrives.
      responseStream.listen((data) {
        accumulatedResponse += data;

        // Check if there's already a bot message we can update.
        final botMessageIndex = _messages.indexWhere(
            (msg) => msg.author.id == 'bot' && msg is types.TextMessage);
        if (botMessageIndex != -1) {
          // Update the existing bot message.
          final updatedMessage = types.TextMessage(
            author: const types.User(id: 'bot'),
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: _messages[botMessageIndex].id,
            text: accumulatedResponse,
          );
          setState(() {
            _messages[botMessageIndex] = updatedMessage;
          });
        } else {
          // If no bot message exists yet, create one.
          final botMessage = types.TextMessage(
            author: const types.User(id: 'bot'),
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: const Uuid().v4(),
            text: accumulatedResponse,
          );
          setState(() {
            _messages.insert(0, botMessage);
          });
        }
      });
    } catch (e) {
      print("Error during chat response: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Chat(
          messages: _messages,
          onSendPressed: _handleSendPressed,
          user: _user,
          theme: DefaultChatTheme(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            primaryColor: Theme.of(context).colorScheme.primary,
            secondaryColor: Theme.of(context).colorScheme.onSurface,
            inputBackgroundColor: Theme.of(context).colorScheme.secondary,
            sentMessageBodyTextStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white),
            receivedMessageBodyTextStyle:
                Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
            sendButtonIcon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.primary,
            ),
            
          ),
        ),
        Positioned(top: 20.0, left: 20.0, child: ButtonReturn())
      ]),
    );
  }
}

class ButtonReturn extends StatelessWidget {
  const ButtonReturn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NavBarPages()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        shadowColor: Colors.transparent,
        padding: EdgeInsets.all(0),
      ),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(3, 3),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.tertiary,
            size: 24,
          ),
        ),
      ),
    );
  }
}
