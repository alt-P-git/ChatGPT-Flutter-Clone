import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButton extends StatelessWidget {
  final String? svgSrc;
  final String label;
  final Color? iconColor;
  final VoidCallback? onPressed;

  const CustomButton({
    required this.svgSrc,
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
      padding:svgSrc != null ? const EdgeInsets.symmetric(vertical: 6, horizontal: 14) : const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
      //border
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFF4E4E4E),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // if (icon != null) Icon(
          //   icon,
          //   size: 20,
          //   color: iconColor,
          // ),
          if(svgSrc != null)
            SvgPicture.asset(
              svgSrc!,
              color: iconColor,
              height: 26,
            ),
          // if (icon != null) const SizedBox(width: 10),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 6),
          child:
          Text(
            label,
            style: const TextStyle(
              fontSize: 14.0,
              color: const Color(0xFF707070),
              fontWeight: FontWeight.w600,
            ),
          )
          ),
        ],
      ),
    ),
    );
  }
}
