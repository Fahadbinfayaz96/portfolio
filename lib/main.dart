import 'package:flutter/material.dart';
import 'package:way_point/screens/portfolio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LitPortfolio(),
    );
  }
}

// class KeyDemoPage extends StatefulWidget {
//   const KeyDemoPage({super.key});

//   @override
//   State<KeyDemoPage> createState() => _KeyDemoPageState();
// }

// class _KeyDemoPageState extends State<KeyDemoPage> {
//   List<Color> colors = [Colors.red, Colors.green, Colors.blue];

//   bool useKeys = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Keys Demo"),
//         actions: [
//           Switch(
//             value: useKeys,
//             onChanged: (v) => setState(() => useKeys = v),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(right: 12),
//             child: Center(child: Text("Use Keys")),
//           )
//         ],
//       ),
//       body: ReorderableListView(
//         onReorder: (oldIndex, newIndex) {
//           setState(() {
//             if (newIndex > oldIndex) newIndex--;
//             final item = colors.removeAt(oldIndex);
//             colors.insert(newIndex, item);
//           });
//         },
//         children: [
//           for (var color in colors)
//             ColorBox(
//               color: color,
//               key: useKeys ? ValueKey(color) : null, // 🔑
//             )
//         ],
//       ),
//     );
//   }
// }

// class ColorBox extends StatefulWidget {
//   final Color color;
//   const ColorBox({super.key, required this.color});

//   @override
//   State<ColorBox> createState() => _ColorBoxState();
// }

// class _ColorBoxState extends State<ColorBox> {
//   int counter = 0;

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       tileColor: widget.color.withOpacity(0.3),
//       title: Text("Box ${widget.color} | counter: $counter"),
//       trailing: IconButton(
//         icon: const Icon(Icons.add),
//         onPressed: () {
//           setState(() => counter++);
//         },
//       ),
//     );
//   }
// }
