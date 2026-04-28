import 'package:flutter/material.dart';
import '../screens/portfolio.dart';
import '../utils/app_colors.dart';

class ContactItem extends StatefulWidget {
  final IconData icon;
  final String label, value, url;
  final Future<void> Function(String) onTap;
  const ContactItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.url,
    required this.onTap,
  });
  @override
  State<ContactItem> createState() => ContactItemState();
}

class ContactItemState extends State<ContactItem> {
  bool _hovered = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: GestureDetector(
      onTap: () => widget.onTap(widget.url),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.all(18),
        transform: Matrix4.translationValues(_hovered ? 6 : 0, 0, 0),
        decoration: BoxDecoration(
          color: _hovered ? C.subtleCard : C.card,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _hovered ? C.accent.withOpacity(0.3) : C.border,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: C.accent.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(widget.icon, color: C.accent, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label.toUpperCase(),
                    style: CustomTextStyle.label(10).copyWith(color: C.muted),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.value,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: C.text,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 14, color: C.muted),
          ],
        ),
      ),
    ),
  );
}
