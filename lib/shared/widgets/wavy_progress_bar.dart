import 'dart:math' as math;
import 'package:flutter/material.dart';

class WavyProgressBar extends StatefulWidget {
  final double progress;
  final Color color;
  final Color backgroundColor;
  final double height;

  const WavyProgressBar({
    super.key,
    required this.progress,
    required this.color,
    required this.backgroundColor,
    this.height = 6,
  });

  @override
  State<WavyProgressBar> createState() => _WavyProgressBarState();
}

class _WavyProgressBarState extends State<WavyProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double waveAmplitude = 3.0;
    // We increase the parent SizedBox height to give the wave room to breathe
    // without being clipped by the container bounds.
    final double totalHeight = widget.height + (waveAmplitude * 2);

    return SizedBox(
      height: totalHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background track (stays centered and fixed height)
          Container(
            height: widget.height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(widget.height / 2),
            ),
          ),
          // Progress wave
          LayoutBuilder(
            builder: (context, constraints) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return ClipPath(
                    clipper: _WavyClipper(
                      progress: widget.progress,
                      animationValue: _controller.value,
                      thickness: widget.height,
                      amplitude: waveAmplitude,
                    ),
                    child: Container(
                      width: constraints.maxWidth,
                      height: totalHeight,
                      decoration: BoxDecoration(
                        color: widget.color,
                        borderRadius: BorderRadius.circular(widget.height / 2),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WavyClipper extends CustomClipper<Path> {
  final double progress;
  final double animationValue;
  final double thickness;
  final double amplitude;

  _WavyClipper({
    required this.progress, 
    required this.animationValue,
    required this.thickness,
    required this.amplitude,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final width = size.width * progress;
    
    if (width <= 0) return path;

    final centerY = size.height / 2;
    final topY = centerY - (thickness / 2);
    final bottomY = centerY + (thickness / 2);

    // Increased wavelength for a more stretched, flowing wave
    const waveLength = 32.0;
    
    // Start at the left, following the top wave pattern
    path.moveTo(0, topY + math.sin((0 / waveLength * 2 * math.pi) + (animationValue * 2 * math.pi)) * amplitude);
    
    // Draw top wavy edge
    for (double i = 0; i <= width; i++) {
      final y = topY + math.sin((i / waveLength * 2 * math.pi) + (animationValue * 2 * math.pi)) * amplitude;
      path.lineTo(i, y);
    }
    
    // Draw right edge connecting top wave to bottom wave
    path.lineTo(width, bottomY + math.sin((width / waveLength * 2 * math.pi) + (animationValue * 2 * math.pi)) * amplitude);
    
    // Draw bottom wavy edge (moving backwards)
    for (double i = width; i >= 0; i--) {
      final y = bottomY + math.sin((i / waveLength * 2 * math.pi) + (animationValue * 2 * math.pi)) * amplitude;
      path.lineTo(i, y);
    }
    
    path.close();
    return path;
  }

  @override
  bool shouldReclip(_WavyClipper oldClipper) => 
      oldClipper.progress != progress || 
      oldClipper.animationValue != animationValue ||
      oldClipper.thickness != thickness;
}
