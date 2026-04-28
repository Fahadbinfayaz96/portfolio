import 'package:flutter/material.dart';

class FadeSlide extends StatelessWidget {
  final AnimationController controller;
  final double begin, end;
  final Widget child;
  const FadeSlide({
    super.key,
    required this.controller,
    required this.begin,
    required this.end,
    required this.child,
  });
  @override
  Widget build(BuildContext context) {
    final fade = CurvedAnimation(
      parent: controller,
      curve: Interval(begin, end, curve: Curves.easeOut),
    );
    return AnimatedBuilder(
      animation: fade,
      builder: (_, __) => Opacity(
        opacity: fade.value,
        child: Transform.translate(
          offset: Offset(0, 24 * (1 - fade.value)),
          child: child,
        ),
      ),
    );
  }
}
