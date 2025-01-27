import 'package:flutter/material.dart';

import 'custom_button.dart';

class Recommendation extends StatefulWidget {
  const Recommendation({Key? key}) : super(key: key);

  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation>
    with SingleTickerProviderStateMixin {
  bool isMorePressed = false;

  final List<Map<String, dynamic>> options = [
    {
      'icon': Icons.image,
      'label': 'Create image',
      'color': const Color(0xFF35AE47)
    },
    {
      'icon': Icons.card_giftcard,
      'label': 'Surprise me',
      'color': const Color(0xFF76D0EB)
    },
    {
      'icon': Icons.bar_chart,
      'label': 'Analyze data',
      'color': const Color(0xFF76D0EB)
    },
    {'icon': Icons.code, 'label': 'Code', 'color': const Color(0xFF6C71FF)},
    {
      'icon': Icons.notes,
      'label': 'Summarize text',
      'color': const Color(0xFFEA8444)
    },
    {'icon': Icons.edit, 'label': 'Help me write', 'color': Colors.pink},
    {
      'icon': Icons.image_search,
      'label': 'Analyze images',
      'color': const Color(0xFFEA8444)
    },
    {
      'icon': Icons.school,
      'label': 'Get advice',
      'color': const Color(0xFF76D0EB)
    },
    {
      'icon': Icons.light_mode,
      'label': 'Make a plan',
      'color': const Color(0xFFE2C541)
    },
    {
      'icon': Icons.lightbulb,
      'label': 'Brainstorm',
      'color': const Color(0xFFE2C541)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "What can I help with?",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: isMorePressed ? 300.0 : 100.0, // Adjust heights as needed
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: isMorePressed
                  ? const NeverScrollableScrollPhysics()
                  : const BouncingScrollPhysics(),
              child: Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                spacing: 10.0,
                runSpacing: 16.0,
                children: [
                  for (var i = 0; i < 4; i++)
                    CustomButton(
                      icon: options[i]['icon'],
                      label: options[i]['label'],
                      iconColor: options[i]['color'],
                      onPressed: () =>
                          print('Button pressed: ${options[i]['label']}'),
                    ),

                  if(!isMorePressed) CustomButton(
                    icon: null,
                    label: 'More',
                    iconColor: null,
                    onPressed: () {
                      setState(() {
                        isMorePressed = !isMorePressed;
                      });
                    },
                  ),

                  for (var i = 4; i < options.length; i++)
                    CustomButton(
                      icon: options[i]['icon'],
                      label: options[i]['label'],
                      iconColor: options[i]['color'],
                      onPressed: () =>
                          print('Button pressed: ${options[i]['label']}'),
                    ),

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
