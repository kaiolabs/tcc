import 'package:flutter/material.dart';

import '../../../core/components/text_pattern.dart';

class Avaliacoes extends StatefulWidget {
  const Avaliacoes({super.key});

  @override
  State<Avaliacoes> createState() => _AvaliacoesState();
}

class _AvaliacoesState extends State<Avaliacoes> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextPattern(
          text: 'Avaliações',
          fontSize: 30,
          color: Colors.black,
        ).black()
      ],
    );
  }
}
