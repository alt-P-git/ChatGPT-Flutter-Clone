import 'dart:ui';

import 'package:chatpgt/widgets/recommendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/Chat.dart';
import '../widgets/BottomSearchBar.dart';
import '../widgets/ChatDisplay.dart';
import '../widgets/SearchScreen.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  String searchOutput = "";
  int? index;
  //list of list of Chat
  List<List<Chat>> chats = [];
  bool isSearchFocused = false;

  void addChat(Chat chat) {
    setState(() {
      if (index != null) {
        // chats[index!] = [...chats[index!], chat];
        chats[index!].insert(0, chat);
      } else {
        chats.add([chat]);
        index = chats.length - 1;
      }
    });

    addBotResponse(
        "Hello! Welcome to ChatGPT clone app. I am a bot. How can I help you?");
  }

  void addBotResponse(String fullMessage) async {
    final botChat = Chat(
      message: "",
      type: 'bot',
      attachments: [],
    );

    setState(() {
      chats[index!].insert(0, botChat);
    });

    List<String> words = fullMessage.split(" ");

    for (var word in words) {
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        botChat.message =
            botChat.message!.isEmpty ? word : "${botChat.message} $word";
      });
    }
  }

  void selectGroup(int indexSet) {
    setState(() {
      index = indexSet;
    });
    _toggleAnimation();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    if (index == null) {
      chats.add([]);
      index = chats.length - 1;
    }
  }

  _toggleAnimation() {
    _animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void newGroup() {
    setState(() {
      chats.add([]);
      index = chats.length - 1;
    });
  }

  void onSearchFocusChanged(bool hasFocus) {
    setState(() {
      isSearchFocused = hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final rightSlide = MediaQuery.of(context).size.width * 0.8;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        final delta = details.primaryDelta ?? 0.0;
        _animationController.value += delta / rightSlide;
      },
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
          _animationController.forward();
        } else if (details.primaryVelocity != null &&
            details.primaryVelocity! < 0) {
          _animationController.reverse();
        } else if (_animationController.value < 0.7) {
          _animationController.reverse();
        } else if (_animationController.value >= 0.7) {
          _animationController.forward();
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          double slide = rightSlide * _animationController.value;
          return Stack(
            children: [
              SearchScreen(
                newGroup: () {
                  newGroup();
                },
                toggleAnimation: () {
                  _toggleAnimation();
                },
                chats: chats,
                index: index ?? 0,
                selectGroup: (i) {
                  selectGroup(i);
                },
                onSearchFocusChanged: (hasFocus) {
                  onSearchFocusChanged(hasFocus);
                },
              ),
              Transform(
                transform: Matrix4.identity()..translate(slide),
                alignment: Alignment.center,
                child: Scaffold(
                  backgroundColor: ColorTween(
                    begin: const Color(0xFF0D0D0D),
                    end: const Color(0xFF080808),
                  ).transform(_animationController.value),
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    titleSpacing: 0,
                    scrolledUnderElevation: 0.0,
                    backgroundColor: ColorTween(
                      begin: const Color(0xFF0D0D0D),
                      end: const Color(0xFF080808),
                    ).transform(_animationController.value),
                    leading: IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Color(0xFFE6E6E6),
                      ),
                      onPressed: () => _toggleAnimation(),
                    ),
                    title: chats[index!].isEmpty
                        ? Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF2F2F2F),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 14),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Get Plus",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                Image.asset(
                                  'assets/icons/gptStar.png',
                                  width: 12,
                                  height: 12,
                                ),
                              ],
                            ),
                          )
                        : Text("ChatGPT"),
                    centerTitle: chats[index!].isEmpty ? true : false,
                    actions: [
                      IconButton(
                        onPressed: () {
                          chats[index!].isEmpty ? null : newGroup();
                        },
                        icon: SvgPicture.asset(
                          'assets/icons/edit.svg',
                          height: 25,
                          width: 25,
                          colorFilter: chats[index!].isEmpty
                              ? const ColorFilter.mode(
                                  Color(0xFF606060), BlendMode.srcIn)
                              : const ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert,
                            color: Color(0xFFE6E6E6), size: 32),
                      ),
                    ],
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        // fit: FlexFit.loose,
                        child: index != null && chats[index!].isEmpty
                            ? const Recommendation()
                            : ChatDisplay(chats: chats[index!]),
                      ),
                      BottomSearchBar(
                        onSearchSubmitted: (chat) {
                          addChat(chat);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
