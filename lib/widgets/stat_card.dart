// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import '../screens/portfolio.dart';
import '../utils/app_colors.dart';

class StatCard extends StatefulWidget {
  final String value, label;
  const StatCard(this.value, this.label, {super.key});
  @override
  State<StatCard> createState() => StatCardState();
}

class StatCardState extends State<StatCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _hovered ? C.subtleCard : C.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _hovered ? C.accent.withOpacity(0.4) : C.border,
        ),
        boxShadow: _hovered
            ? [BoxShadow(color: C.accent.withOpacity(0.15), blurRadius: 20)]
            : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w800,
              color: C.text,
              height: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(widget.label, style: CustomTextStyle.label(11)),
        ],
      ),
    ),
  );
}
