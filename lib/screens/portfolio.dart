import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/project_model.dart';
import '../data/skills_model.dart';
import '../utils/app_colors.dart';
import '../widgets/contact_item.dart';
import '../widgets/fade_slide.dart';
import '../widgets/ghost_button.dart';
import '../widgets/glow_orbit.dart';
import '../widgets/primary_button.dart';
import '../widgets/project_card.dart';
import '../widgets/section.dart';
import '../widgets/skill_group.dart';
import '../widgets/social_button.dart';
import '../widgets/stat_card.dart';
import 'package:icons_plus/icons_plus.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});
  @override
  State<PortfolioPage> createState() => PortfolioPageState();
}

class PortfolioPageState extends State<PortfolioPage>
    with TickerProviderStateMixin {
  final _scroll = ScrollController();
  late final AnimationController _heroCtrl;
  late final AnimationController _bgCtrl;
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _heroCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
    _bgCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _scroll.dispose();
    _heroCtrl.dispose();
    _bgCtrl.dispose();
    super.dispose();
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _scrollTo(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.bg,
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _bgCtrl,
            builder: (_, __) {
              final t = _bgCtrl.value;
              return Stack(
                children: [
                  Positioned(
                    top: -200 + 40 * math.sin(t * math.pi),
                    right: -200 + 30 * math.cos(t * math.pi),
                    child: GlowOrb(
                      color: C.accent,
                      size: 600,
                      opacity: 0.15 + 0.05 * t,
                    ),
                  ),
                  Positioned(
                    bottom: -150 + 30 * math.cos(t * math.pi),
                    left: -100 + 20 * math.sin(t * math.pi),
                    child: GlowOrb(
                      color: C.accent2,
                      size: 450,
                      opacity: 0.10 + 0.04 * t,
                    ),
                  ),
                ],
              );
            },
          ),

          CustomScrollView(
            controller: _scroll,
            slivers: [
              _buildHero(),
              _buildAbout(),
              _buildEducation(),
              _buildSkills(),
              _buildProjects(),
              _buildContact(),
              _buildFooter(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return SliverToBoxAdapter(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 40, 28, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeSlide(
                controller: _heroCtrl,
                begin: 0.0,
                end: 0.2,
                child: Row(
                  children: [
                    Container(width: 36, height: 1, color: C.accent3),
                    const SizedBox(width: 12),
                    Text(
                      'Available for freelance & full-time',
                      style: CustomTextStyle.label(
                        12,
                      ).copyWith(color: C.accent3, letterSpacing: 1.8),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              FadeSlide(
                controller: _heroCtrl,
                begin: 0.15,
                end: 0.5,
                child: RichText(
                  text: TextSpan(
                    style: CustomTextStyle.display(52).copyWith(height: 1.1),
                    children: [
                      const TextSpan(text: 'Fahad\n'),
                      const TextSpan(
                        text: 'Bin ',
                        style: TextStyle(color: C.muted),
                      ),
                      TextSpan(
                        text: 'Fayaz',
                        style: TextStyle(
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [C.accent, C.accent2, C.accent3],
                            ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              FadeSlide(
                controller: _heroCtrl,
                begin: 0.35,
                end: 0.65,
                child: Text(
                  'Mobile Developer specializing in Flutter, Native (Android & iOS), and Backend (Node.js)',
                  style: TextStyle(
                    fontSize: 18,
                    color: C.muted,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'serif',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              FadeSlide(
                controller: _heroCtrl,
                begin: 0.5,
                end: 0.8,
                child: Row(
                  children: [
                    PrimaryBtn('View Work ↗', () {
                      _scrollTo(_projectsKey);
                    }),
                    const SizedBox(width: 12),
                    GhostBtn('Contact', () {
                      _scrollTo(_contactKey);
                    }),
                  ],
                ),
              ),
              // const Spacer(),
              // FadeSlide(
              //   controller: _heroCtrl,
              //   begin: 0.7,
              //   end: 1.0,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       MiniStat('4+', 'Years'),
              //       MiniStat('8+', 'Projects'),
              //       MiniStat('10K+', 'LoC'),
              //       MiniStat('100%', 'Satisfaction'),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAbout() {
    return SliverToBoxAdapter(
      child: Section(
        label: 'About',
        title: 'Building apps\nthat actually matter',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: C.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: C.border),
              ),
              child: Text(
                "Hi, I'm Fahad — a Mobile Developer with 4+ years of experience building high-quality apps using Flutter, along with native development for Android (Kotlin) and iOS (Swift).\nI also build backend systems using Node.js, Express.js, and MongoDB — delivering complete end-to-end solutions.\nI care about clean architecture, scalable design, and experiences that feel genuinely smooth.",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.8,
                  color: C.muted,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Expanded(child: StatCard('8+', 'Projects Shipped')),
                const SizedBox(width: 12),
                Expanded(child: StatCard('4+', 'Years Exp.')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: StatCard('10K+', 'Lines of Code')),
                const SizedBox(width: 12),
                Expanded(child: StatCard('100%', 'Satisfaction')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducation() {
    return SliverToBoxAdapter(
      child: Section(
        label: 'Education',
        title: 'Academic\nfoundation',
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: C.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: C.border),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF13131F), Color(0xFF1A1A2E)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: C.accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      color: C.accent,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'B.E. Computer Science Engineering',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: C.text,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'SSM College of Science and technology, University of Kashmir',
                          style: TextStyle(
                            fontSize: 14,
                            color: C.accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: C.accent3.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Batch 2022',
                      style: TextStyle(
                        fontSize: 11,
                        color: C.accent3,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'Comprehensive CSE program covering software engineering, algorithms, data structures, and modern development methodologies ETC.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.7,
                  color: C.muted,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkills() {
    return SliverToBoxAdapter(
      child: Container(
        color: C.surface,

        child: Section(
          label: 'Skills',
          title: "Tech I love\nworking with",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkillGroup('Mobile', mobile),
              const SizedBox(height: 32),
              SkillGroup('Backend', backend),
              const SizedBox(height: 32),
              SkillGroup('Architecture & Tools', arch),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjects() {
    return SliverToBoxAdapter(
      key: _projectsKey,
      child: Section(
        label: 'Work',
        title: 'Selected\nprojects',
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width > 900
                ? 3
                : MediaQuery.of(context).size.width > 600
                ? 2
                : 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: MediaQuery.of(context).size.width > 900
                ? 1.2
                : MediaQuery.of(context).size.width > 600
                ? 0.75
                : 1.2,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return ProjectCard(project: projects[index], onLaunch: _launch);
          },
        ),
      ),
    );
  }

  Widget _buildContact() {
    return SliverToBoxAdapter(
      key: _contactKey,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D0D22), C.bg],
          ),
        ),
        child: Section(
          label: 'Contact',
          title: "Let's build\nsomething\namazing.",
          child: Column(
            children: [
              ContactItem(
                icon: Icons.phone_rounded,
                label: 'Phone',
                value: '+91 7006844920',
                url: 'tel:+917006844920',
                onTap: _launch,
              ),
              const SizedBox(height: 12),
              ContactItem(
                icon: Icons.email_rounded,
                label: 'Email',
                value: 'fahadbinfayaz100@gmail.com',
                url: 'mailto:fahadbinfayaz100@gmail.com',
                onTap: _launch,
              ),
              const SizedBox(height: 12),
              ContactItem(
                icon: Icons.location_on_rounded,
                label: 'Location',
                value: 'Srinagar, J&K, India',
                url: 'https://maps.google.com/?q=Srinagar,Kashmir',
                onTap: _launch,
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: PrimaryBtn(
                      '↓  Download CV',
                      () => _launch(
                        'https://drive.google.com/uc?export=download&id=1NFgDMF3MEY0nVbnftAj7A52ecUIB6rLP',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialBtn(
                    Bootstrap.github,
                    () => _launch('https://github.com/Fahadbinfayaz96'),
                  ),
                  const SizedBox(width: 12),
                  SocialBtn(
                    Bootstrap.linkedin,
                    () => _launch(
                      'https://linkedin.com/in/fahad-bin-fayaz-87349221a/',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: C.border)),
        ),
        child: Text(
          '© 2025 Fahad Bin Fayaz  ·  Crafted with Flutter & ❤️',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: C.muted,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}

class CustomTextStyle {
  static const mono = TextStyle(fontFamily: 'monospace');
  static TextStyle display(double size) => TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w800,
    color: C.text,
    letterSpacing: -size * 0.02,
    height: 0.93,
  );
  static TextStyle label(double size) => TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: C.muted,
    letterSpacing: size * 0.2,
    fontFamily: 'monospace',
  );
}
