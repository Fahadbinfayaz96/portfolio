import 'package:flutter/material.dart';

import 'package:way_point/screens/portfolio.dart';

import 'utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fahad Bin Fayaz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: C.bg,
        useMaterial3: true,
      ),
      home: const PortfolioPage(),
    );
  }
}
