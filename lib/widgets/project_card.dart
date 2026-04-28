import 'package:flutter/material.dart';

import '../data/project_model.dart';
import '../screens/portfolio.dart';
import '../utils/app_colors.dart';
import 'link_button.dart';

class ProjectCard extends StatefulWidget {
  final Project project;
  final Future<void> Function(String) onLaunch;
  const ProjectCard({super.key, required this.project, required this.onLaunch});
  @override
  State<ProjectCard> createState() => ProjectCardState();
}

class ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) {
    final p = widget.project;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: p.featured ? const Color(0xFF111128) : C.card,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _hovered
                ? C.accent.withOpacity(0.35)
                : (p.featured ? C.accent.withOpacity(0.2) : C.border),
          ),
          gradient: p.featured
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF111128), Color(0xFF160D1F)],
                )
              : null,
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: C.accent.withOpacity(0.12),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  p.num,
                  style: CustomTextStyle.label(11).copyWith(color: C.accent),
                ),
                const Spacer(),
                if (p.featured)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: C.accent3.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '★ Open Source',
                      style: TextStyle(
                        fontSize: 10,
                        color: C.accent3,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              p.name,
              style: TextStyle(
                fontSize: p.featured ? 22 : 18,
                fontWeight: FontWeight.w700,
                color: C.text,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              p.desc,
              style: TextStyle(
                fontSize: 13,
                height: 1.7,
                color: C.muted,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: p.tags
                  .map(
                    (t) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: C.accent.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: C.accent.withOpacity(0.2)),
                      ),
                      child: Text(
                        t,
                        style: TextStyle(
                          fontSize: 11,
                          color: C.accent,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: C.bg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.code_rounded, size: 14, color: C.accent),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      p.tech,
                      style: TextStyle(
                        fontSize: 12,
                        color: C.muted,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (p.github != null || p.pub != null) ...[
              const SizedBox(height: 14),
              Row(
                children: [
                  if (p.github != null)
                    LinkBtn('→ GitHub', () => widget.onLaunch(p.github!)),
                  if (p.pub != null) ...[
                    const SizedBox(width: 16),
                    LinkBtn('→ pub.dev', () => widget.onLaunch(p.pub!)),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
