// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class GlowOrb extends StatelessWidget {
  final Color color;
  final double size, opacity;
  const GlowOrb({
    super.key,
    required this.color,
    required this.size,
    required this.opacity,
  });
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [color.withOpacity(opacity), Colors.transparent],
      ),
    ),
  );
}
