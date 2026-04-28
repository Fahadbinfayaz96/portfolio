import 'dart:ui';

class Skill {
  final String name;
  final Color dot;
  const Skill(this.name, this.dot);
}

const mobile = [
  Skill('Flutter', Color(0xFF54C5F8)),
  Skill('Dart', Color(0xFF00B4AB)),
  Skill('Kotlin', Color(0xFFE9742D)),
  Skill('Jetpack Compose', Color(0xFF3DDC84)),
  Skill('Swift', Color(0xFFF05138)),
  Skill('UIKit', Color(0xFF0070C9)),
  Skill('Java', Color(0xFFB07219)),
];
const backend = [
  Skill('Node.js', Color(0xFF68A063)),
  Skill('Express.js', Color(0xFF888888)),
  Skill('MongoDB', Color(0xFF4DB33D)),
  Skill('REST APIs', Color(0xFFF0DB4F)),
  Skill('C# / .NET MVC', Color(0xFF823DE0)),
];
const arch = [
  Skill('BLoC', Color(0xFF6C63FF)),
  Skill('Provider', Color(0xFFA855F7)),
  Skill('Clean Architecture', Color(0xFF00E5C3)),
  Skill('Firebase', Color(0xFFFF9500)),
  Skill('Git / GitHub', Color(0xFFF05032)),
  Skill('UI/UX Design', Color(0xFFFF6BBA)),
  Skill('CI/CD', Color(0xFF555555)),
];
