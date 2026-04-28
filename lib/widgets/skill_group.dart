import 'package:flutter/material.dart';

import '../data/skills_model.dart';
import '../screens/portfolio.dart';
import '../utils/app_colors.dart';
import 'skill_pill.dart';

class SkillGroup extends StatelessWidget {
  final String label;
  final List<Skill> skills;
  const SkillGroup(this.label, this.skills, {super.key});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label.toUpperCase(),
        style: CustomTextStyle.label(
          10,
        ).copyWith(color: C.muted, letterSpacing: 2),
      ),
      const SizedBox(height: 14),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: skills.map((s) => SkillPill(s)).toList(),
      ),
    ],
  );
}
