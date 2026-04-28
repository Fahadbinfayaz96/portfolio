import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class GradientText extends StatelessWidget {
  final String text;
  final double fontSize;
  const GradientText(this.text, {super.key, required this.fontSize});
  @override
  Widget build(BuildContext context) => ShaderMask(
    shaderCallback: (b) => const LinearGradient(
      colors: [C.accent, C.accent2, C.accent3],
    ).createShader(b),
    child: Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        letterSpacing: fontSize * -0.02,
      ),
    ),
  );
}
