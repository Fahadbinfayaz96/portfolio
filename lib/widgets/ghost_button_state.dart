import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'ghost_button.dart';

class GhostBtnState extends State<GhostBtn> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: _hovered ? C.accent : C.border),
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: _hovered ? C.accent : C.text,
            letterSpacing: 0.8,
          ),
        ),
      ),
    ),
  );
}
