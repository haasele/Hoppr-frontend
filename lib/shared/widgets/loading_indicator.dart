import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Expressive loading indicator with animated polygons
/// Similar to Kotlin's LoadingIndicator with RoundedPolygons
class LoadingIndicator extends StatefulWidget {
  final Color color;
  final double size;
  final int polygons;

  const LoadingIndicator({
    this.color = const Color(0xFF6750A4),
    this.size = 48.0,
    this.polygons = 3,
    super.key,
  });

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _LoadingIndicatorPainter(
              progress: _controller.value,
              color: widget.color,
              polygons: widget.polygons,
            ),
          );
        },
      ),
    );
  }
}

class _LoadingIndicatorPainter extends CustomPainter {
  final double progress;
  final Color color;
  final int polygons;

  _LoadingIndicatorPainter({
    required this.progress,
    required this.color,
    required this.polygons,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2 * 0.8;

    for (int i = 0; i < polygons; i++) {
      final polygonProgress = (progress + i / polygons) % 1.0;
      final radius = maxRadius * (0.3 + 0.7 * (1 - polygonProgress));
      final opacity = 0.3 + 0.7 * (1 - polygonProgress);
      final rotation = polygonProgress * 2 * math.pi;

      final paint = Paint()
        ..color = color.withOpacity(opacity)
        ..style = PaintingStyle.fill;

      _drawRoundedPolygon(
        canvas,
        center,
        radius,
        6, // hexagon
        rotation,
        paint,
      );
    }
  }

  void _drawRoundedPolygon(
    Canvas canvas,
    Offset center,
    double radius,
    int sides,
    double rotation,
    Paint paint,
  ) {
    final path = Path();
    final angleStep = 2 * math.pi / sides;
    final cornerRadius = radius * 0.2;

    for (int i = 0; i < sides; i++) {
      final angle = rotation + i * angleStep - math.pi / 2;
      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      final point = Offset(x, y);

      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        // Add rounded corner
        final prevAngle = rotation + (i - 1) * angleStep - math.pi / 2;
        final prevX = center.dx + radius * math.cos(prevAngle);
        final prevY = center.dy + radius * math.sin(prevAngle);
        final prevPoint = Offset(prevX, prevY);

        final midX = (prevPoint.dx + point.dx) / 2;
        final midY = (prevPoint.dy + point.dy) / 2;
        path.quadraticBezierTo(prevPoint.dx, prevPoint.dy, midX, midY);
        path.lineTo(point.dx, point.dy);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_LoadingIndicatorPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.polygons != polygons;
  }
}
