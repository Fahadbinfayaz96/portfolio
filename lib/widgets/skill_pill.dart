import 'package:flutter/material.dart';
import '../data/skills_model.dart';
import '../utils/app_colors.dart';

class SkillPill extends StatefulWidget {
  final Skill skill;
  const SkillPill(this.skill, {super.key});
  @override
  State<SkillPill> createState() => SkillPillState();
}

class SkillPillState extends State<SkillPill> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: _hovered ? widget.skill.dot.withOpacity(0.1) : C.card,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _hovered ? widget.skill.dot.withOpacity(0.5) : C.border,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: widget.skill.dot,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            widget.skill.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: C.text,
            ),
          ),
        ],
      ),
    ),
  );
}
