import 'package:chatpgt/models/Chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomSearchBar extends StatefulWidget {
  final Function(Chat) onSearchSubmitted;

  const BottomSearchBar({Key? key, required this.onSearchSubmitted})
      : super(key: key);

  @override
  _BottomSearchBarState createState() => _BottomSearchBarState();
}

class _BottomSearchBarState extends State<BottomSearchBar> {
  bool isSearchActive = false;
  TextEditingController _controller = TextEditingController();
  List<String> attachments = [];

  void addAttachment(String attachment) {
    setState(() {
      attachments.add(attachment);
    });
  }

  void removeAttachment(int index) {
    setState(() {
      attachments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AnimatedCrossFade(
                firstChild: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          addAttachment("Camera Attachment");
                          print('Camera icon pressed');
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          addAttachment("Gallery Attachment");
                          print('Image icon pressed');
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.image_outlined),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          addAttachment("Folder Attachment");
                          print('Folder icon pressed');
                        },
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                          child: Icon(Icons.folder_outlined),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          addAttachment("Web Attachment");
                          print('Web icon pressed');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: SvgPicture.asset(
                            'assets/icons/gptWeb.svg',
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                secondChild: Row(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Material(
                      color: Colors.grey[700],
                      shape: const CircleBorder(),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            isSearchActive = false;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: Color(0xFFE6E6E6),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
                crossFadeState: isSearchActive
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 100),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF242424),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            if (attachments.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(left: 10, top: 20, bottom: 8),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: attachments.map((attachment) {
                                        int index = attachments.indexOf(attachment);
                                        return Stack(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(right: 8),
                                              width: 100,
                                              height: 100,
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
                                            Positioned(
                                              top: 4,
                                              right: 14,
                                              child: GestureDetector(
                                                onTap: () => removeAttachment(index),
                                                child: const CircleAvatar(
                                                  radius: 13,
                                                  backgroundColor: Color(0xFF242424),
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 18,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            TextField(
                              maxLines: 10,
                              minLines: 1,
                              controller: _controller,
                              onTap: () {
                                setState(() {
                                  isSearchActive = true;
                                });
                              },
                              onChanged: (text) {
                                setState(() {});
                              },
                              onSubmitted: (value) {
                                print('Search submitted: $value');
                                Chat chat = Chat(message: _controller.text, type: "user", attachments: attachments);
                                widget.onSearchSubmitted(chat);
                              },
                              decoration: const InputDecoration(
                                hintText: 'Message',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  color: Color(0xFFE6E6E6),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () {
                            setState(() {
                              isSearchActive = false;
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.mic,
                              color: Color(0xFFE6E6E6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 4),
              AnimatedPadding(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(vertical: 4),
                curve: Curves.easeInOut,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 150),
                  transitionBuilder: (child, animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: _controller.text.isEmpty && attachments.isEmpty
                      ? Material(
                    key: const ValueKey("voice_icon"),
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          print('Voice icon pressed');
                        },
                        child: SvgPicture.asset(
                          'assets/icons/gptVoice.svg',
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                  )
                      : Material(
                    key: const ValueKey("arrow_icon"),
                    color: Colors.white,
                    shape: const CircleBorder(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Chat chat = Chat(message: _controller.text, type: "user", attachments: [...attachments]);
                          widget.onSearchSubmitted(chat);
                          print('Bottom search bar : ${_controller.text}');
                          setState(() {
                            _controller.clear();
                            attachments.clear();
                          });
                        },
                        child: const Icon(
                          Icons.arrow_upward,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
