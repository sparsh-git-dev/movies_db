import 'package:flutter/material.dart';

class TMDBLogo extends StatelessWidget {
  const TMDBLogo({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShaderMask(
        shaderCallback: (bounds) {
          return LinearGradient(
            colors: [Color(0xFF89E3C7), Color(0xFF3AC2D3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
        },
        child: Text(
          'TMDB Movies',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arial',
          ),
        ),
      ),
    );
  }
}
