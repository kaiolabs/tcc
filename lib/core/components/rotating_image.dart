import 'package:flutter/material.dart';

class RotatingImage extends StatefulWidget {
  final String imagePath;
  final double size;
  const RotatingImage({super.key, required this.imagePath, required this.size});

  @override
  _RotatingImageState createState() => _RotatingImageState();
}

class _RotatingImageState extends State<RotatingImage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2), // Duração da animação (2 segundos neste caso)
    )..repeat(); // Repetir a animação indefinidamente
  }

  @override
  void dispose() {
    _animationController.dispose(); // Lembre-se de liberar recursos quando não for mais necessário.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animationController,
      child: Image.asset(
        widget.imagePath,
        width: widget.size,
      ),
    );
  }
}
