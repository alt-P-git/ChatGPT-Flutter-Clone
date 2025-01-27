import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Color? iconColor;
  final VoidCallback? onPressed;

  const CustomButton({
    required this.icon,
    required this.label,
    required this.iconColor,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector (
      onTap: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
          child: Container(
      padding: const EdgeInsets.all(10),
      //border
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white38,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(
            icon,
            size: 20,
            color: iconColor,
          ),
          // if (icon != null) const SizedBox(width: 10),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 6),
          child:
          Text(
            label,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white38,
            ),
          )
          ),
        ],
      ),
    ),
    );
  }
}
