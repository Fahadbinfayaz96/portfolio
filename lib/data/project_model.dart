class Project {
  final String num, name, desc, tech;
  final List<String> tags;
  final bool featured;
  final String? github, pub;
  const Project({
    required this.num,
    required this.name,
    required this.desc,
    required this.tech,
    required this.tags,
    this.featured = false,
    this.github,
    this.pub,
  });
}

const projects = [
  Project(
    num: '00',
    name: 'fd_arch_gen',
    featured: true,
    desc:
        'Clean Architecture code generator for Flutter that scaffolds complete features with BLoC or Riverpod. Cuts hours of boilerplate into seconds.',
    tech: 'Dart · CLI · Clean Architecture · BLoC · Riverpod · GetIt',
    tags: ['pub.dev', 'CLI Tool', 'Open Source'],
    github: 'https://github.com/Fahadbinfayaz96/fd_arch_gen',
    pub: 'https://pub.dev/packages/fd_arch_gen',
  ),
  Project(
    num: '01',
    name: 'Instacoach',
    desc:
        'Dual coaching platform (coach + client apps) with real-time scheduling, video calls, payments & progress tracking. 1K+ active users.',
    tech: 'Flutter · Firebase · BLoC · GetX · Stripe · GetStream',
    tags: ['1K+ Users', 'Real-time', 'Sports'],
  ),
  Project(
    num: '02',
    name: 'SafeView',
    desc:
        'Secure video streaming for children with full parental controls, content filtering, time limits, and safe recommendations.',
    tech: 'Flutter · Firebase · BLoC · YouTube API · GetX',
    tags: ['Parental Control', 'Safe', 'Streaming'],
  ),
  Project(
    num: '03',
    name: 'FieldPulse',
    desc:
        'Enterprise field workforce management with real-time GPS tracking, task assignment, and performance analytics.',
    tech: 'Flutter · Firebase · BLoC · Google Maps · Clean Architecture',
    tags: ['GPS', 'Enterprise', 'Analytics'],
  ),
  Project(
    num: '04',
    name: 'MyBigPlate',
    desc:
        'Digital food ordering with restaurant discovery, table booking, and seamless payment integration.',
    tech: 'Flutter · Laravel · BLoC · Firebase · MVC',
    tags: ['Food', 'Payments', 'Reviews'],
  ),
  Project(
    num: '05',
    name: 'Hotel Check-ins',
    desc:
        'Streamlined hotel guest check-in/out with secure data handling and digital room keys.',
    tech: 'Flutter · Provider · Firebase',
    tags: ['Fast', 'Secure', 'Hospitality'],
  ),
  Project(
    num: '06',
    name: 'Car Rental Backend',
    desc:
        'Backend system with auth, booking management, and role-based access control etc.',
    tech: 'Node.js · Express.js · MongoDB · Firbase',
    tags: ['REST API', 'Auth', 'Scalable'],
  ),
  Project(
    num: '07',
    name: 'Blog App Backend',
    desc:
        'Backend for blog platform with CRUD operations, auth, validation, pagination etc.',
    tech: 'Node.js · Express.js · MongoDB · Firbase',
    tags: ['CURD', 'Auth', 'Validation'],
  ),
  Project(
    num: '08',
    name: 'Fruit Delivery',
    desc:
        'Native ordering & delivery tracking app built separately for Android and iOS.',
    tech: 'Kotlin (Android) · Swift (iOS) · Firebase Realtime DB',
    tags: ['Native', 'Delivery', 'Firebase'],
  ),

  Project(
    num: '09',
    name: 'Omega Wallpapers',
    desc:
        'Platform for browsing and downloading high-quality wallpapers across multiple categories with seamless experience',
    tech: 'Kotlin (Android) · Swift (iOS) · Firebase Realtime DB',
    tags: ['HD wallpaper', 'Categories', 'Download'],
  ),
];
