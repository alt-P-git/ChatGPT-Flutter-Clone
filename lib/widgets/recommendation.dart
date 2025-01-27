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
      'icon': 'assets/icons/createImage.svg',
      'label': 'Create image',
      'color': const Color(0xFF35AE47)
    },
    {
      'icon': 'assets/icons/surpriseMe.svg',
      'label': 'Surprise me',
      'color': const Color(0xFF76D0EB)
    },
    {
      'icon': 'assets/icons/makeAPlan.svg',
      'label': 'Brainstorm',
      'color': const Color(0xFFE2C541)
    },
    {'icon': 'assets/icons/code.svg', 'label': 'Code', 'color': const Color(0xFF6C71FF)},
    {
      'icon': 'assets/icons/summarizeText.svg',
      'label': 'Summarize text',
      'color': const Color(0xFFEA8444)
    },
    {'icon': 'assets/icons/helpMeWrite.svg', 'label': 'Help me write', 'color': const Color(0xFFCB8BD0)},
    {
      'icon': 'assets/icons/analyzeImages.svg',
      'label': 'Analyze images',
      'color': const Color(0xFF6C71FF)
    },
    {
      'icon': 'assets/icons/getAdvice.svg',
      'label': 'Get advice',
      'color': const Color(0xFF76D0EB)
    },
    {
      'icon': 'assets/icons/makeAPlan.svg',
      'label': 'Make a plan',
      'color': const Color(0xFFE2C541)
    },
    {
      'icon': 'assets/icons/analyzeData.svg',
      'label': 'Analyze data',
      'color': const Color(0xFF76D0EB)
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
          height: isMorePressed ? 300.0 : 110.0, // Adjust heights as needed
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Wrap(
                alignment: WrapAlignment.center,
                direction: Axis.horizontal,
                spacing: 10.0,
                runSpacing: 16.0,
                children: [
                  for (var i = 0; i < 3; i++)
                    CustomButton(
                      svgSrc: options[i]['icon'],
                      label: options[i]['label'],
                      iconColor: options[i]['color'],
                      onPressed: () =>
                          print('Button pressed: ${options[i]['label']}'),
                    ),

                  if(!isMorePressed) CustomButton(
                    svgSrc: null,
                    label: 'More',
                    iconColor: null,
                    onPressed: () {
                      setState(() {
                        isMorePressed = !isMorePressed;
                      });
                    },
                  ),

                  if(isMorePressed)
                  for (var i = 3; i < options.length; i++)
                    CustomButton(
                      svgSrc: options[i]['icon'],
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
