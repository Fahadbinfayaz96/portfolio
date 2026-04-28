import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class SocialBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const SocialBtn(this.label, this.onTap, {super.key});
  @override
  State<SocialBtn> createState() => SocialBtnState();
}

class SocialBtnState extends State<SocialBtn> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: _hovered ? C.accent.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _hovered ? C.accent : C.border),
        ),
        alignment: Alignment.center,
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: _hovered ? C.accent : C.muted,
            fontFamily: 'monospace',
          ),
        ),
      ),
    ),
  );
}
