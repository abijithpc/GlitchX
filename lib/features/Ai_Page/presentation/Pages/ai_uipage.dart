import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Data/Models/chat_message.dart';
import 'package:glitchxscndprjt/features/Ai_Page/presentation/Bloc/chatbot_bloc.dart';
import 'package:glitchxscndprjt/features/Ai_Page/presentation/Bloc/chatbot_event.dart';
import 'package:glitchxscndprjt/features/Ai_Page/presentation/Bloc/chatbot_state.dart';
import 'package:uuid/uuid.dart';

class AiUipage extends StatefulWidget {
  const AiUipage({super.key});

  @override
  State<AiUipage> createState() => _AiUipageState();
}

class _AiUipageState extends State<AiUipage> {
  final _controller = TextEditingController();
  final _sessionId = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C),
      appBar: AppBar(
        title: const Text(
          'GlitchX Assistant',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ScreenBackGround(
        screenHeight: screen.height,
        screenWidth: screen.width,
        alignment: Alignment.topCenter,
        widget: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatbotBloc, ChatbotState>(
                builder: (context, state) {
                  final messages = state.messages;

                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final msg = messages[messages.length - 1 - index];
                      final isUser = msg.sender == Sender.user;

                      return Align(
                        alignment:
                            isUser
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(14),
                          constraints: BoxConstraints(
                            maxWidth: screen.width * 0.75,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isUser
                                    ? const Color(0xFF4A90E2)
                                    : const Color(0xFF2C2F48),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft: Radius.circular(isUser ? 16 : 0),
                              bottomRight: Radius.circular(isUser ? 0 : 16),
                            ),
                          ),
                          child: Text(
                            msg.text,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            BlocBuilder<ChatbotBloc, ChatbotState>(
              builder: (context, state) {
                if (state is ChatbotLoading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Bot is typing...",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            /// Input Field
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: const Color(0xFF2A2A3C),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3A3A4D),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _controller,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Send a message...',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      final text = _controller.text.trim();
                      if (text.isNotEmpty) {
                        context.read<ChatbotBloc>().add(
                          SendMessageEvent(
                            sessionId: _sessionId,
                            message: text,
                          ),
                        );
                        _controller.clear();
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blueAccent,
                      ),
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
