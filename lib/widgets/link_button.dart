import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class LinkBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const LinkBtn(this.label, this.onTap, {super.key});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Text(
      label,
      style: TextStyle(
        fontSize: 12,
        color: C.accent3,
        fontFamily: 'monospace',
        decoration: TextDecoration.underline,
        decorationColor: C.accent3,
      ),
    ),
  );
}
