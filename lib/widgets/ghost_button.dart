import 'package:flutter/material.dart';
import 'package:way_point/widgets/ghost_button_state.dart';

class GhostBtn extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const GhostBtn(this.label, this.onTap, {super.key});
  @override
  State<GhostBtn> createState() => GhostBtnState();
}
