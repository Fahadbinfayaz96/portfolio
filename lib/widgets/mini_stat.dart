import 'package:flutter/material.dart';

import '../screens/portfolio.dart';
import '../utils/app_colors.dart';

class MiniStat extends StatelessWidget {
  final String value, label;
  const MiniStat(this.value, this.label, {super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        value,
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: C.text,
        ),
      ),
      Text(label, style: CustomTextStyle.label(10).copyWith(color: C.muted)),
    ],
  );
}
