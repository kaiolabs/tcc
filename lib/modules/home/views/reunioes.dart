import 'package:flutter/material.dart';

import '../../../core/components/text_pattern.dart';

class Reunioes extends StatefulWidget {
  const Reunioes({super.key});

  @override
  State<Reunioes> createState() => _ReunioesState();
}

class _ReunioesState extends State<Reunioes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextPattern(
          text: 'Reuniões',
          fontSize: 30,
          color: Colors.black,
        ).black()
      ],
    );
  }
}
