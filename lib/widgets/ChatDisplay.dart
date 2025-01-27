import 'package:flutter/material.dart';

import '../models/Chat.dart';

class ChatDisplay extends StatefulWidget {
  final List<Chat> chats;

  const ChatDisplay({
    Key? key,
    required this.chats,
  }) : super(key: key);

  @override
  State<ChatDisplay> createState() => _ChatDisplayState();
}

class _ChatDisplayState extends State<ChatDisplay> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
        shrinkWrap: true,
        reverse: true,
        padding: const EdgeInsets.all(10),
        itemCount: widget.chats.length,
        itemBuilder: (context, index) {
          final chat = widget.chats[index];
          final isUser = chat.type == 'user';
          final attachments = chat.attachments;

          return Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              width: isUser ? MediaQuery.of(context).size.width * 0.7 : MediaQuery.of(context).size.width * 0.9,
              child: Column(
                crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // for file in chat['files']
                  for(var file in attachments)
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      width: 100,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          "File",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  if(chat.message != null && chat.message != "" ) Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUser ? Color(0xFF181818) : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      chat.message!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
