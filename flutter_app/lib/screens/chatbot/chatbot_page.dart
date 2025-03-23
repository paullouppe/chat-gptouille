import 'package:flutter/material.dart';
import 'package:flutter_app/screens/pages_navbar.dart';
import 'package:flutter_app/services/requests.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:uuid/uuid.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '12345');

  void _handleSendPressed(types.PartialText message) async {
    final userMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    setState(() {
      _messages.insert(0, userMessage);
    });

    final requestData = {'user_message': message.text};

    try {
      Stream<String> responseStream =
          await streamRequest(requestData, 'http://localhost:8080/chat/');

      String accumulatedResponse = '';

      responseStream.listen((data) {
        accumulatedResponse += data;

        final botMessageIndex = _messages.indexWhere(
            (msg) => msg.author.id == 'bot' && msg is types.TextMessage);
        if (botMessageIndex != -1) {
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
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Image.asset('assets/images/chatbot.png', height: 150),
                Text(
                  'Bonjour !\nQue puis-je faire pour vous ?',
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Vous pouvez me demander des idées de recette, je serais ravi de vous répondre !',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                Expanded(
                  child: Chat(
                    messages: _messages,
                    onSendPressed: _handleSendPressed,
                    user: _user,
                    theme: DefaultChatTheme(
                      inputBackgroundColor:
                          Theme.of(context).colorScheme.tertiary,
                      inputTextColor: Theme.of(context).colorScheme.secondary,
                      inputMargin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      inputTextStyle: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      inputBorderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(15),
                        right: Radius.circular(15),
                      ),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      primaryColor: Theme.of(context).primaryColor,
                      sentMessageBodyTextStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white),
                      receivedMessageBodyTextStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.black),
                      sendButtonIcon: Icon(
                        Icons.send,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(top: 20.0, left: 20.0, child: ButtonReturn())
        ],
      ),
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
