import 'package:flutter/material.dart';

import '../../../core/components/text_pattern.dart';

class Configs extends StatefulWidget {
  const Configs({super.key});

  @override
  State<Configs> createState() => _ConfigsState();
}

class _ConfigsState extends State<Configs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextPattern(
          text: 'Configurações',
          fontSize: 30,
          color: Colors.black,
        ).black()
      ],
    );
  }
}
