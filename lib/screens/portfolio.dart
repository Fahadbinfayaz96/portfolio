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
    final double expandedHeight = (300 - _scrollOffset * shrinkRate).clamp(
      0.0,
      300.0,
    );
    final double avatarSize = expandedHeight > 120
        ? 150
        : (expandedHeight * 0.8).clamp(0.0, 150.0);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
      
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
                            'Flutter Developer | Kotlin + Jetpack Compose | Cross-Platform & UI/UX Craftsman',
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

        
          SliverList(
            delegate: SliverChildListDelegate([
           
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
                      "Hello, I'm Fahad Bin Fayaz, a dedicated Flutter developer with 3+ years of hands-on experience delivering cross-platform mobile apps for Android and iOS. Skilled in building production-ready apps with clean architecture (BLoC), Firebase integrations, and scalable UI/UX. I also have additional experience in native Android development using Kotlin and Jetpack Compose, enabling me to build performant platform-specific features when needed. I’ve successfully delivered 7+ apps including streaming, restaurant, sports coaching, and enterprise solutions, improving performance, user engagement, and operational efficiency",
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 30),
          
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
                            period: '',
                            description:
                                'Completed comprehensive computer science program with focus on software engineering principles, algorithms, data structures, and software development methodologies.',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
               
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
                        _buildSkillChip('Kotlin', Icons.android),
                        _buildSkillChip('Jetpack Compose', Icons.phone_android),
                        _buildSkillChip('Firebase', Icons.cloud),
                        _buildSkillChip('REST APIs', Icons.api),
                        _buildSkillChip('Provider', Icons.widgets),
                        _buildSkillChip('Bloc', Icons.view_quilt),
                        _buildSkillChip('Git', Icons.history),
                        _buildSkillChip('UI/UX Design', Icons.design_services),
                        _buildSkillChip('Java', Icons.coffee),
                        _buildSkillChip('C#', Icons.developer_mode),
                        _buildSkillChip('.NET MVC', Icons.layers),
                      ],
                    ),
                  ],
                ),
              ),

           
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

                   
                    _buildProjectCard(
                      context,
                      projectName: 'Instacoach (Coach App)',
                      description:
                          'An app for coaches to manage availability, view scheduled sessions, and handle bookings.',
                      techUsed: 'Flutter, Firebase, Bloc, GetX, MVC, GetStream',
                    ),
                    SizedBox(height: 25),

                  
                    _buildProjectCard(
                      context,
                      projectName: 'Instacoach (Client App)',
                      description:
                          'A client-facing app to schedule lessons with coaches, offering in-person and virtual booking options.',
                      techUsed:
                          'Flutter, Firebase, Bloc, GetX, Clean Architecture, Stripe, GetStream',
                    ),
                    SizedBox(height: 25),

                    
                    _buildProjectCard(
                      context,
                      projectName: 'MyBigPlate',
                      description:
                          'A digital food ordering solution integrating a Laravel backend with Flutter frontend. Features: Login, restaurant directory, table booking, etc.',
                      techUsed: 'Flutter, Bloc, MVC, Firebase',
                    ),
                    SizedBox(height: 25),

              
                    _buildProjectCard(
                      context,
                      projectName: 'Omega Wallpapers',
                      description:
                          'A platform for browsing and downloading high-quality wallpapers across multiple categories.',
                      techUsed: 'HTML, CSS , .NetCore, MVC, Js',
                    ),
                    SizedBox(height: 25),

              
                    _buildProjectCard(
                      context,
                      projectName: 'SafeView',
                      description:
                          'A video streaming app for kids where they can watch safe content under full parental control. Parents can set preferences, block unsafe videos, and define time limits.',
                      techUsed:
                          'Flutter, Firebase, Bloc, GetX, MVC, YouTube API',
                    ),
                    SizedBox(height: 25),

                   
                    _buildProjectCard(
                      context,
                      projectName: 'FieldPluse',
                      description:
                          'An app that allows assigning tasks to field workers and tracking their progress in real time.',
                      techUsed:
                          'Flutter, Firebase, Bloc, GetX, Clean Architecture, Google Maps',
                    ),
                    SizedBox(height: 25),

        
                    _buildProjectCard(
                      context,
                      projectName: 'Hotel Check-ins',
                      description:
                          'An app streamlining hotel guest check-in/out processes with secure guest data handling.',
                      techUsed: 'Flutter, Provider, Firebase',
                    ),
                    SizedBox(height: 25),

        
                    _buildProjectCard(
                      context,
                      projectName: 'Digital Menu',
                      description:
                          'A digital restaurant menu app enabling customers to browse and place orders efficiently.',
                      techUsed: 'Flutter, MVC, QR Code',
                    ),
                  ],
                ),
              ),

           
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

                 
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                 
                          ListTile(
                            leading: Icon(Icons.phone, color: Colors.white70),
                            title: Text(
                              '+91 7006844920', 
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () => _launchURL(
                              'tel:+917006844920',
                            ), 
                          ),

                   
                          ListTile(
                            leading: Icon(Icons.email, color: Colors.white70),
                            title: Text(
                              'fahadbinfayaz100@gmail.com',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () =>
                                _launchURL('mailto:fahadbinfayaz100@gmail.com'),
                          ),

                  
                          ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Colors.white70,
                            ),
                            title: Text(
                              'srinagar, Jammu and Kashmir, India',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                            
                              _launchURL(
                                'https://maps.google.com/?q=Kashmir,India',
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _downloadCV,
                        icon: Icon(Icons.download, size: 24),
                        label: Text(
                          'Download CV',
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blue.shade800,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                 
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
                      ],
                    ),
                  ],
                ),
              ),
          
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

  Future<void> _downloadCV() async {
    const cvUrl ="https://drive.google.com/uc?export=download&id=1GZPE1wFItfEoyeKXwdwFmtVxePT3P1C3";
             

    try {
      if (await canLaunchUrl(Uri.parse(cvUrl))) {
        await launchUrl(Uri.parse(cvUrl));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not download CV. Please try again later.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading CV. Please try again.')),
      );
    }
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
      elevation: 3,
      color: Colors.white,
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
