import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchScreen extends StatefulWidget {
  final Function newGroup;
  final Function toggleAnimation;
  final List<dynamic> chats;
  final int index;
  final Function selectGroup;
  final Function(bool) onSearchFocusChanged;

  const SearchScreen({
    required this.newGroup,
    required this.toggleAnimation,
    required this.chats,
    required this.index,
    required this.selectGroup,
    required this.onSearchFocusChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      widget.onSearchFocusChanged(_focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: Row(
              children: [
                Expanded(
                  child: Focus(
                    focusNode: _focusNode, // Attach the focus node here
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Color(0xFFE1E1E1),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFFE1E1E1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFF242424),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () {
                    widget.newGroup();
                    widget.toggleAnimation();
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/edit.svg',
                    height: 25,
                    width: 25,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFE6E6E6),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 16),
        color: const Color(0xFF0D0D0D),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          children: [
            Container(
              color: const Color(0xFF2F2F2F),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/logo.svg',
                      height: 28,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFE6E6E6),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'ChatGPT',
                      style: TextStyle(
                          color: Color(0xFFE6E6E6),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/explore.svg',
                      height: 28,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFFE6E6E6),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text(
                      'Explore GPTs',
                      style: TextStyle(
                          color: Color(0xFFE6E6E6),
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              height: 2,
              color: const Color(0xFF2F2F2F),
            ),
            Container(
              padding: const EdgeInsets.only(top: 12, left: 16, bottom: 18),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Chats',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Color(0xFFE6E6E6),
                  fontSize: 14,
                ),
              ),
            ),
            Expanded(
              // fit: FlexFit.loose,
              child: ListView.builder(
                itemCount: widget.chats.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      widget.selectGroup(i);
                    },
                    child: Container(
                      color: widget.index == i
                          ? const Color(0xFF2F2F2F)
                          : const Color(0xFF0D0D0D),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 16),
                      child: Text(
                        "Chat ${i + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF5C6BC0),
                    ),
                    width: 35,
                    height: 35,
                    child: const Center(
                      child: Text(
                        "P",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    'Prit Bhanushali',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Icon(
                    Icons.arrow_drop_down_outlined,
                    color: Colors.white,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
