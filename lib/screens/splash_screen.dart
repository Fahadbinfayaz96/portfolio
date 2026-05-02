import 'dart:math' as math;
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  final Widget destination;
  const SplashScreen({super.key, required this.destination});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _orbCtrl;

  late final AnimationController _progressCtrl;

  late final AnimationController _counterCtrl;

  late final AnimationController _drawCtrl;
  late final AnimationController _exitCtrl;

  late final Animation<double> _progressAnim;
  late final Animation<int> _counterAnim;
  late final Animation<double> _drawAnim;
  late final Animation<double> _exitAnim;

  @override
  void initState() {
    super.initState();

    _orbCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _drawCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _drawAnim = CurvedAnimation(parent: _drawCtrl, curve: Curves.easeInOut);

    _progressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _progressAnim = CurvedAnimation(
      parent: _progressCtrl,
      curve: Curves.easeInOutCubic,
    );

    _counterCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    );
    _counterAnim = IntTween(begin: 0, end: 100).animate(
      CurvedAnimation(parent: _counterCtrl, curve: Curves.easeInOutCubic),
    );

    _exitCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _exitAnim = CurvedAnimation(parent: _exitCtrl, curve: Curves.easeIn);

    _startSequence();
  }

  Future<void> _startSequence() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _drawCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _progressCtrl.forward();
    _counterCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 2600));
    await _exitCtrl.forward();
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => widget.destination,
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    }
  }

  @override
  void dispose() {
    _orbCtrl.dispose();
    _progressCtrl.dispose();
    _counterCtrl.dispose();
    _drawCtrl.dispose();
    _exitCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _exitAnim,
      builder: (_, child) =>
          Opacity(opacity: 1 - _exitAnim.value, child: child),
      child: Scaffold(
        backgroundColor: const Color(0xFF080810),
        body: Stack(
          children: [
            AnimatedBuilder(
              animation: _orbCtrl,
              builder: (_, __) {
                final t = _orbCtrl.value;
                return Stack(
                  children: [
                    Positioned(
                      top: -180 + 40 * math.sin(t * math.pi),
                      right: -180 + 30 * math.cos(t * math.pi),
                      child: _GlowOrb(
                        color: const Color(0xFF6C63FF),
                        size: 480,
                        opacity: 0.18 + 0.06 * t,
                      ),
                    ),
                    Positioned(
                      bottom: -120 + 30 * math.cos(t * math.pi),
                      left: -100 + 20 * math.sin(t * math.pi),
                      child: _GlowOrb(
                        color: const Color(0xFFFF6BBA),
                        size: 360,
                        opacity: 0.12 + 0.04 * t,
                      ),
                    ),
                    Positioned(
                      bottom: 80 + 20 * math.sin(t * math.pi * 1.3),
                      right: 40 + 15 * math.cos(t * math.pi * 0.8),
                      child: _GlowOrb(
                        color: const Color(0xFF00E5C3),
                        size: 200,
                        opacity: 0.08 + 0.04 * t,
                      ),
                    ),
                  ],
                );
              },
            ),

            Positioned.fill(
              child: Opacity(
                opacity: 0.04,
                child: CustomPaint(painter: _NoisePainter()),
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _drawAnim,
                    builder: (_, __) => CustomPaint(
                      size: const Size(100, 100),
                      painter: _InitialsPainter(_drawAnim.value),
                    ),
                  ),
                  const SizedBox(height: 40),

                  AnimatedBuilder(
                    animation: _drawCtrl,
                    builder: (_, __) => Opacity(
                      opacity: _drawAnim.value,
                      child: Transform.translate(
                        offset: Offset(0, 12 * (1 - _drawAnim.value)),
                        child: Column(
                          children: [
                            ShaderMask(
                              shaderCallback: (b) => const LinearGradient(
                                colors: [
                                  Color(0xFF6C63FF),
                                  Color(0xFFFF6BBA),
                                  Color(0xFF00E5C3),
                                ],
                              ).createShader(b),
                              child: const Text(
                                'FAHAD BIN FAYAZ',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: 4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Mobile Developer',
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF7A798F),
                                letterSpacing: 2.5,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: Column(
                      children: [
                        AnimatedBuilder(
                          animation: _counterAnim,
                          builder: (_, __) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Loading',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: const Color(0xFF7A798F),
                                  letterSpacing: 2,
                                  fontFamily: 'monospace',
                                ),
                              ),
                              Text(
                                '${_counterAnim.value}%',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF6C63FF),
                                  letterSpacing: 1,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: AnimatedBuilder(
                            animation: _progressAnim,
                            builder: (_, __) => FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: _progressAnim.value,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6C63FF),
                                      Color(0xFF00E5C3),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(
                                        0xFF6C63FF,
                                      ).withOpacity(0.6),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              left: 24,
              bottom: 32,
              child: AnimatedBuilder(
                animation: _drawAnim,
                builder: (_, __) => Opacity(
                  opacity: _drawAnim.value,
                  child: const Text(
                    '// portfolio v1.0',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF3A3A5C),
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 24,
              bottom: 32,
              child: AnimatedBuilder(
                animation: _drawAnim,
                builder: (_, __) => Opacity(
                  opacity: _drawAnim.value,
                  child: const Text(
                    'Flutter 🩵',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF3A3A5C),
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InitialsPainter extends CustomPainter {
  final double progress;
  _InitialsPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final ringPaint = Paint()
      ..color = Colors.white.withOpacity(0.06)
      ..style = PaintingStyle.fill;
    final borderPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF6C63FF), Color(0xFFFF6BBA)],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: 50))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    final hexPath = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (math.pi / 3) * i - math.pi / 6;
      final x = cx + 46 * math.cos(angle);
      final y = cy + 46 * math.sin(angle);
      if (i == 0) {
        hexPath.moveTo(x, y);
      } else {
        hexPath.lineTo(x, y);
      }
    }
    hexPath.close();
    canvas.drawPath(hexPath, ringPaint);

    final metrics = hexPath.computeMetrics().first;
    final drawn = metrics.extractPath(0, metrics.length * progress);
    canvas.drawPath(drawn, borderPaint);

    if (progress > 0.5) {
      final glowOpacity = ((progress - 0.5) * 2).clamp(0.0, 1.0);
      canvas.drawCircle(
        Offset(cx, cy),
        28,
        Paint()
          ..shader = RadialGradient(
            colors: [
              const Color(0xFF6C63FF).withOpacity(0.3 * glowOpacity),
              Colors.transparent,
            ],
          ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: 28)),
      );

      final textPaint = Paint()
        ..color = Colors.white.withOpacity(glowOpacity)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round;

      final fPath = Path();
      fPath.moveTo(cx - 10, cy - 14);
      fPath.lineTo(cx - 10, cy + 14);
      fPath.moveTo(cx - 10, cy - 14);
      fPath.lineTo(cx + 10, cy - 14);
      fPath.moveTo(cx - 10, cy);
      fPath.lineTo(cx + 4, cy);

      canvas.drawPath(fPath, textPaint);
    }
  }

  @override
  bool shouldRepaint(_InitialsPainter old) => old.progress != progress;
}

class _GlowOrb extends StatelessWidget {
  final Color color;
  final double size, opacity;
  const _GlowOrb({
    required this.color,
    required this.size,
    required this.opacity,
  });
  @override
  Widget build(BuildContext context) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: RadialGradient(
        colors: [color.withOpacity(opacity), Colors.transparent],
      ),
    ),
  );
}

class _NoisePainter extends CustomPainter {
  final _rand = math.Random(42);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    for (int i = 0; i < 4000; i++) {
      canvas.drawCircle(
        Offset(
          _rand.nextDouble() * size.width,
          _rand.nextDouble() * size.height,
        ),
        _rand.nextDouble() * 0.8,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
