import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fahad Bin Fayaz - Flutter Developer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const PortfolioHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({super.key});

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0.0;
  bool _isDark = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double shrinkRate = 0.5;
    final double expandedHeight = (300 - _scrollOffset * shrinkRate).clamp(
      120.0,
      300.0,
    );
    final double avatarSize = expandedHeight > 150 ? 120 : expandedHeight * 0.5;

    return Scaffold(
      backgroundColor: _isDark ? Colors.grey[900] : Colors.grey[50],
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            backgroundColor: _isDark ? Colors.grey[900] : Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade800,
                      Colors.purple.shade700,
                      Colors.deepPurple.shade900,
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: -50,
                      right: -50,
                      child: Opacity(
                        opacity: 0.1,
                        child: Transform.rotate(
                          angle: 0.3,
                          child: Icon(
                            Icons.code_rounded,
                            size: 250,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -30,
                      left: -30,
                      child: Opacity(
                        opacity: 0.1,
                        child: Transform.rotate(
                          angle: -0.2,
                          child: Icon(
                            Icons.phone_iphone_rounded,
                            size: 200,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            height: avatarSize,
                            width: avatarSize,
                            child: CircleAvatar(
                              backgroundImage: const AssetImage(
                                'assets/profile/dp.jpeg',
                              ),
                              backgroundColor: Colors.white,
                              onBackgroundImageError: (_, __) =>
                                  const Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Fahad Bin Fayaz',
                            style: TextStyle(
                              fontSize: expandedHeight > 200 ? 32 : 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.2,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.3),
                                  offset: const Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Mobile Application Developer | Flutter, Native (Android & iOS), Backend (Node.js)',
                              style: TextStyle(
                                fontSize: expandedHeight > 200 ? 16 : 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildSection(
                context,
                title: 'About Me',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Hi, I’m Fahad Bin Fayaz — a Mobile Developer with 4+ years of experience building high-quality apps using Flutter, along with native development for Android (Kotlin) and iOS (Swift).I also have hands-on experience building backend systems using Node.js, Express.js, and MongoDB, allowing me to develop complete, end-to-end solutions.I focus on clean architecture, scalable design, and delivering smooth, user-friendly experiences.",
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.6,
                        color: _isDark ? Colors.white70 : Colors.grey[800],
                      ),
                      textAlign: TextAlign.justify,
                    ),

                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade50, Colors.purple.shade50],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.blue.shade100,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem('8+', 'Projects'),
                          _buildStatItem('4+', 'Years'),
                          _buildStatItem('10K+', 'Lines of Code'),
                          _buildStatItem('100%', 'Satisfaction'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              _buildSection(
                context,
                title: 'Education',
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _isDark ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.school_rounded,
                              color: Colors.blue.shade800,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bachelor of Engineering in Computer Science',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: _isDark
                                        ? Colors.white
                                        : Colors.grey[900],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Kashmir University',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Completed comprehensive computer science program with focus on software engineering principles, algorithms, data structures, and software development methodologies.',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: _isDark ? Colors.white70 : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              _buildSection(
                context,
                title: 'Skills & Expertise',
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _buildSkillChip('Flutter', Bootstrap.google, Colors.blue),
                    _buildSkillChip(
                      'Dart',
                      Bootstrap.code,
                      Colors.lightBlue.shade400,
                    ),
                    _buildSkillChip('Kotlin', Bootstrap.android, Colors.orange),
                    _buildSkillChip(
                      'Jetpack Compose',
                      Bootstrap.android2,
                      Colors.green.shade400,
                    ),
                    _buildSkillChip('Swift', Bootstrap.apple, Colors.grey),
                    _buildSkillChip(
                      'UIKit',
                      Bootstrap.window,
                      Colors.blue.shade300,
                    ),

                    _buildSkillChip('Node.js', Bootstrap.server, Colors.green),
                    _buildSkillChip(
                      'Express.js',
                      Bootstrap.layers,
                      Colors.grey,
                    ),
                    _buildSkillChip(
                      'MongoDB',
                      Bootstrap.database,
                      Colors.green.shade700,
                    ),
                    _buildSkillChip(
                      'REST APIs',
                      Bootstrap.link,
                      Colors.blueGrey,
                    ),

                    _buildSkillChip('Firebase', Bootstrap.google, Colors.amber),
                    _buildSkillChip('CI/CD', Bootstrap.gear_fill, Colors.grey),
                    _buildSkillChip('Provider', Bootstrap.box, Colors.purple),
                    _buildSkillChip('Bloc', Bootstrap.diagram_3, Colors.blue),
                    _buildSkillChip('Git/Github', Bootstrap.git, Colors.orange),
                    _buildSkillChip(
                      'UI/UX Design',
                      Bootstrap.palette,
                      Colors.pink,
                    ),
                    _buildSkillChip('Java', Icons.coffee, Colors.brown),
                    _buildSkillChip('C#', Bootstrap.window, Colors.purple),
                    _buildSkillChip('.NET MVC', Bootstrap.windows, Colors.blue),
                    _buildSkillChip(
                      'Clean Architecture',
                      Bootstrap.layers,
                      Colors.teal,
                    ),
                  ],
                ),
              ),

              _buildSection(
                context,
                title: 'Featured Projects',
                child: Column(
                  children: [
                    _buildProjectCard(
                      context,
                      projectName: 'Instacoach (Coach & Client Apps)',
                      description:
                          'A comprehensive coaching platform with separate apps for coaches and clients. Features real-time session scheduling, video calls, payment integration, and progress tracking.',
                      techUsed:
                          'Flutter, Firebase, Bloc, GetX, Stripe, GetStream',
                      highlights: ['1K+ Users', 'Sports Coaching', 'Real-time'],
                    ),
                    const SizedBox(height: 20),
                    _buildProjectCard(
                      context,
                      projectName: 'SafeView - Kids Video Streaming',
                      description:
                          'A secure video streaming platform for children with full parental control. Features content filtering, time limits, and safe video recommendations.',
                      techUsed: 'Flutter, Firebase, Bloc, YouTube API, GetX',
                      highlights: [
                        'Parental Control',
                        'Videos Streaming',
                        'Safe',
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildProjectCard(
                      context,
                      projectName: 'FieldPluse - Task Management',
                      description:
                          'Enterprise solution for field workforce management with real-time tracking, task assignment, and performance analytics.',
                      techUsed:
                          'Flutter, Firebase, Bloc, Google Maps, Clean Architecture',
                      highlights: ['Real-time GPS', 'Task Managment'],
                    ),
                    const SizedBox(height: 20),
                    _buildProjectCard(
                      context,
                      projectName: 'MyBigPlate - Food Ordering',
                      description:
                          'Digital food ordering platform with restaurant discovery, table booking, and seamless payment integration.',
                      techUsed: 'Flutter, Laravel Backend, Bloc, Firebase, MVC',
                      highlights: ["Food Ordring", 'Online Payment', 'Reviews'],
                    ),

                    const SizedBox(height: 20),

                    _buildProjectCard(
                      context,
                      projectName: 'Omega Wallpapers',
                      description:
                          'A platform for browsing and downloading high-quality wallpapers across multiple categories with seamless user experience.',
                      techUsed: 'HTML, CSS, .NET Core, MVC, JavaScript',
                      highlights: ['HD Wallpapers', 'Categories', 'Download'],
                    ),
                    const SizedBox(height: 20),

                    _buildProjectCard(
                      context,
                      projectName: 'Hotel Check-ins',
                      description:
                          'An app streamlining hotel guest check-in/out processes with secure guest data handling and digital room keys.',
                      techUsed: 'Flutter, Provider, Firebase',
                      highlights: ['Fast Check-in', 'Secure Data'],
                    ),
                    SizedBox(height: 20),

                    const SizedBox(height: 20),

                    _buildProjectCard(
                      context,
                      projectName: 'Car Rental Backend',
                      description:
                          'Backend system for car rental platform with authentication, booking management, and role-based access control.',
                      techUsed: 'Node.js, Express.js, MongoDB, JWT',
                      highlights: ['REST APIs', 'Auth', 'Scalable'],
                    ),

                    const SizedBox(height: 20),

                    _buildProjectCard(
                      context,
                      projectName: 'Blog API',
                      description:
                          'RESTful API for blog platform with CRUD operations, authentication, validation, and pagination.',
                      techUsed: 'Node.js, Express.js, MongoDB',
                      highlights: ['CRUD', 'Auth', 'Validation'],
                    ),

                    const SizedBox(height: 20),

                    _buildProjectCard(
                      context,
                      projectName: 'Fruit Delivery App (Native)',
                      description:
                          'Native mobile app for fruit ordering and delivery tracking built for both Android and iOS.',
                      techUsed: 'Kotlin (Android), Swift (iOS)',
                      highlights: [
                        'Native',
                        'Delivery',
                        'Firebase realtime db',
                      ],
                    ),
                  ],
                ),
              ),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.shade800,
                      Colors.purple.shade700,
                      Colors.deepPurple.shade900,
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 60,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Let\'s Create Something Amazing',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'I\'m always open to discussing new projects, creative ideas, or opportunities to be part of your vision.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),

                      Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          children: [
                            _buildContactCard(
                              icon: Icons.phone_rounded,
                              title: 'Phone',
                              value: '+91 7006844920',
                              onTap: () => _launchURL('tel:+917006844920'),
                            ),
                            const SizedBox(height: 12),
                            _buildContactCard(
                              icon: Icons.email_rounded,
                              title: 'Email',
                              value: 'fahadbinfayaz100@gmail.com',
                              onTap: () => _launchURL(
                                'mailto:fahadbinfayaz100@gmail.com',
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildContactCard(
                              icon: Icons.location_on_rounded,
                              title: 'Location',
                              value: 'Srinagar, Jammu & Kashmir, India',
                              onTap: () => _launchURL(
                                'https://maps.google.com/?q=Srinagar,Kashmir',
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),

                      ElevatedButton.icon(
                        onPressed: _downloadCV,
                        icon: const Icon(Icons.download_rounded, size: 24),
                        label: const Text(
                          'Download CV',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue.shade800,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 5,
                        ),
                      ),

                      const SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            icon: Bootstrap.github,
                            onPressed: () => _launchURL(
                              'https://github.com/Fahadbinfayaz96',
                            ),
                          ),
                          const SizedBox(width: 20),
                          _buildSocialButton(
                            icon: Bootstrap.linkedin,
                            onPressed: () => _launchURL(
                              'https://linkedin.com/in/fahad-bin-fayaz-87349221a/',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Footer
              Container(
                padding: const EdgeInsets.all(20),
                color: _isDark ? Colors.black : Colors.grey[900],
                child: Center(
                  child: Text(
                    '© 2024 Fahad Bin Fayaz. Crafted with Flutter & ❤️',
                    style: TextStyle(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 32,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade800, Colors.purple.shade600],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: _isDark ? Colors.white : Colors.grey[900],
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white70,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _isDark ? Colors.white : Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: Icon(icon, color: Colors.blue.shade800, size: 24)),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context, {
    required String projectName,
    required String description,
    required String techUsed,
    List<String>? highlights,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: _isDark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.folder_rounded,
                    color: Colors.blue.shade800,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    projectName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: _isDark ? Colors.white : Colors.grey[900],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              description,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: _isDark ? Colors.white70 : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 16),
            if (highlights != null) ...[
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: highlights.map((highlight) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      highlight,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue.shade800,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _isDark ? Colors.grey[900] : Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.code_rounded,
                    size: 18,
                    color: Colors.blue.shade600,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      techUsed,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _isDark ? Colors.white70 : Colors.grey[800],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadCV() async {
    const cvUrl =
        "https://drive.google.com/uc?export=download&id=1NFgDMF3MEY0nVbnftAj7A52ecUIB6rLP";

    try {
      if (await canLaunchUrl(Uri.parse(cvUrl))) {
        await launchUrl(Uri.parse(cvUrl));
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not download CV. Please try again later.'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error downloading CV: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
