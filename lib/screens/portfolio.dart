import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class LitPortfolio extends StatelessWidget {
  const LitPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Name - Flutter Developer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
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

  // Helper function to launch URLs
  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double shrinkRate = 0.5;
    final double expandedHeight = 300 - _scrollOffset * shrinkRate;
    final double avatarSize = expandedHeight > 120 ? 150 : expandedHeight * 0.8;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // App Bar with shrinking effect
          SliverAppBar(
            expandedHeight: 300,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue.shade800, Colors.purple.shade600],
                  ),
                ),
                child: Stack(
                  children: [
                    // Animated background elements
                    Positioned(
                      top: 50,
                      right: 30,
                      child: Opacity(
                        opacity: 0.1,
                        child: Icon(Icons.code, size: 150, color: Colors.white),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Opacity(
                        opacity: 0.1,
                        child: Icon(
                          Icons.phone_iphone,
                          size: 120,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            height: avatarSize,
                            width: avatarSize,
                            child: CircleAvatar(
                              backgroundImage: AssetImage(
                                'assets/profile/dp.jpeg',
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Fahad Bin Fayaz',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Flutter Developer & UI/UX Enthusiast',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
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

          // Main content
          SliverList(
            delegate: SliverChildListDelegate([
              // About Me Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Me',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Hello! I\'m Fahad Bin Fayaz, a passionate Flutter developer with a knack for creating beautiful, performant, and user-friendly cross-platform applications. I love turning ideas into reality through code and am constantly learning new technologies to stay ahead of the curve.',
                      style: TextStyle(fontSize: 16, height: 1.6),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 30),
                    // Education Section
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 40,
                      ),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Education',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade800,
                            ),
                          ),
                          SizedBox(height: 30),
                          _buildEducationItem(
                            degree:
                                'Bachelor of Engineering in Computer Science',
                            institution:
                                'SSM College of Science and Technology, Kashmir University',
                            period: 'Batch sep 2017',
                            description:
                                'Completed comprehensive computer science program with focus on software engineering principles, algorithms, data structures, and software development methodologies.',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    // Stats or achievements
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('7+', 'Projects'),
                        _buildStatItem('3+', 'Years Experience'),
                        _buildStatItem('10K+', 'Lines of Code'),
                      ],
                    ),
                  ],
                ),
              ),

              // Skills Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                color: Colors.grey[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Skills & Expertise',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 30),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _buildSkillChip('Flutter', Icons.phone_iphone),
                        _buildSkillChip('Dart', Icons.code),
                        _buildSkillChip('Firebase', Icons.cloud),
                        _buildSkillChip('REST APIs', Icons.api),
                        _buildSkillChip('Provider', Icons.widgets),
                        _buildSkillChip('Bloc', Icons.view_quilt),
                        _buildSkillChip('Git', Icons.history),
                        _buildSkillChip('UI/UX Design', Icons.design_services),
                        _buildSkillChip('C#', Icons.developer_mode),
                        _buildSkillChip('.NET MVC', Icons.layers),
                        _buildSkillChip('Java', Icons.coffee),
                      ],
                    ),
                  ],
                ),
              ),

              // Projects Section
              // Projects Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Featured Projects',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade800,
                      ),
                    ),
                    SizedBox(height: 30),

                    // Instacoach (Coach App)
                    _buildProjectCard(
                      context,
                      projectName: 'Instacoach (Coach App)',
                      description:
                          'An app for coaches to manage availability, view scheduled sessions, and handle bookings.',
                      techUsed: 'Flutter, Firebase, Provider',
                    ),
                    SizedBox(height: 25),

                    // Instacoach (Client App)
                    _buildProjectCard(
                      context,
                      projectName: 'Instacoach (Client App)',
                      description:
                          'A client-facing app to schedule lessons with coaches, offering in-person and virtual booking options.',
                      techUsed: 'Flutter, Firebase, Stripe',
                    ),
                    SizedBox(height: 25),

                    // MyBigPlate
                    _buildProjectCard(
                      context,
                      projectName: 'MyBigPlate',
                      description:
                          'A digital food ordering solution integrating a Laravel backend with Flutter frontend. Features: Login, restaurant directory, table booking, etc.',
                      techUsed: 'Flutter, Laravel, REST API',
                    ),
                    SizedBox(height: 25),

                    // Omega Wallpapers
                    _buildProjectCard(
                      context,
                      projectName: 'Omega Wallpapers',
                      description:
                          'A platform for browsing and downloading high-quality wallpapers across multiple categories.',
                      techUsed: 'Flutter, Wallpaper API, Cached Network Image',
                    ),
                    SizedBox(height: 25),

                    // SafeView
                    _buildProjectCard(
                      context,
                      projectName: 'SafeView',
                      description:
                          'A video streaming app for kids where they can watch safe content under full parental control. Parents can set preferences, block unsafe videos, and define time limits.',
                      techUsed: 'Flutter, Firebase, YouTube API',
                    ),
                    SizedBox(height: 25),

                    // FieldPluse
                    _buildProjectCard(
                      context,
                      projectName: 'FieldPluse',
                      description:
                          'An app that allows assigning tasks to field workers and tracking their progress in real time.',
                      techUsed: 'Flutter, Firebase, Google Maps',
                    ),
                    SizedBox(height: 25),

                    // Hotel Check-ins
                    _buildProjectCard(
                      context,
                      projectName: 'Hotel Check-ins',
                      description:
                          'An app streamlining hotel guest check-in/out processes with secure guest data handling.',
                      techUsed: 'Flutter, Firebase, Secure Storage',
                    ),
                    SizedBox(height: 25),

                    // Digital Menu
                    _buildProjectCard(
                      context,
                      projectName: 'Digital Menu',
                      description:
                          'A digital restaurant menu app enabling customers to browse and place orders efficiently.',
                      techUsed: 'Flutter, Firebase, QR Code',
                    ),
                  ],
                ),
              ),

              // Contact Section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 60),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue.shade800, Colors.purple.shade600],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Let\'s Connect!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'I\'m always open to discussing new projects, creative ideas, or opportunities to be part of your vision.',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          icon: Icons.email,
                          onPressed: () =>
                              _launchURL('mailto:fahadbinfayaz100@gmail.com'),
                          color: Colors.red,
                        ),
                        SizedBox(width: 20),
                        _buildSocialButton(
                          icon: AntDesign.github_outline,
                          onPressed: () =>
                              _launchURL('https://github.com/Fahadbinfayaz96'),
                          color: Colors.black,
                        ),
                        SizedBox(width: 20),
                        _buildSocialButton(
                          icon: AntDesign.linkedin_outline,
                          onPressed: () => _launchURL(
                            'https://linkedin.com/in/fahad-bin-fayaz-87349221a',
                          ),
                          color: Colors.blue.shade700,
                        ),
                        // SizedBox(width: 20),
                        // _buildSocialButton(
                        //   icon: AntDesign.twitter_outline,
                        //   onPressed: () =>
                        //       _launchURL('https://twitter.com/yourprofile'),
                        //   color: Colors.blue.shade400,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),

              // Footer
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.grey[900],
                child: Center(
                  child: Text(
                    '© 2023 Fahad Bin Fayaz. Made with Flutter & ❤️',
                    style: TextStyle(color: Colors.white54),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItem({
    required String degree,
    required String institution,
    required String period,
    String description = '',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                degree,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Text(
              period,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          institution,
          style: TextStyle(
            fontSize: 18,
            color: Colors.blue.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 12),
        if (description.isNotEmpty)
          Text(
            description,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.5,
            ),
          ),
        SizedBox(height: 24),
      ],
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
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildSkillChip(String label, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 18, color: Colors.blue),
      label: Text(label),
      backgroundColor: Colors.white,
      side: BorderSide(color: Colors.blue.shade100),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: Center(child: Icon(icon, color: color, size: 24)),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context, {
    required String projectName,
    required String description,
    required String techUsed,
    String? githubUrl,

    String? playStoreUrl,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  projectName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
                SizedBox(height: 15),
                Text(
                  'Tech: $techUsed',
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                ),
                SizedBox(height: 15),
                if (githubUrl != null) ...[
                  Row(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => _launchURL(githubUrl ?? ""),
                        icon: Icon(AntDesign.code_outline, size: 18),
                        label: Text('View Code'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade800,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      if (playStoreUrl != null)
                        ElevatedButton.icon(
                          onPressed: () => _launchURL(playStoreUrl),
                          icon: Icon(AntDesign.shop_outline, size: 18),
                          label: Text('View App'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
