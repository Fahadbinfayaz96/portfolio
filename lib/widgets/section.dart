import 'package:flutter/material.dart';

import '../screens/portfolio.dart';
import '../utils/app_colors.dart';

class Section extends StatelessWidget {
  final String label, title;
  final Widget child;
  const Section({
    super.key,
    required this.label,
    required this.title,
    required this.child,
  });
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 56),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '//',
              style: CustomTextStyle.label(11).copyWith(color: C.muted),
            ),
            const SizedBox(width: 8),
            Text(
              label.toUpperCase(),
              style: CustomTextStyle.label(11).copyWith(color: C.accent),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(title, style: CustomTextStyle.display(34).copyWith(height: 1.2)),
        const SizedBox(height: 36),
        child,
      ],
    ),
  );
}
