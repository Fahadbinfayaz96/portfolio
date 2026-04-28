import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class PrimaryBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const PrimaryBtn(this.label, this.onTap, {super.key});
  @override
  State<PrimaryBtn> createState() => _PrimaryBtnState();
}

class _PrimaryBtnState extends State<PrimaryBtn> {
  bool _pressed = false;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: widget.onTap,
    onTapDown: (_) => setState(() => _pressed = true),
    onTapUp: (_) => setState(() => _pressed = false),
    onTapCancel: () => setState(() => _pressed = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      decoration: BoxDecoration(
        color: _pressed ? C.accent.withOpacity(0.7) : C.accent,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: C.accent.withOpacity(_pressed ? 0.2 : 0.45),
            blurRadius: _pressed ? 10 : 24,
          ),
        ],
      ),
      child: Text(
        widget.label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          letterSpacing: 0.8,
        ),
      ),
    ),
  );
}
