import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class DashedBorder extends StatelessWidget {
  final double strokeWidth;
  final Color color;
  final double borderRadius;
  final Widget child;

  const DashedBorder({
    Key? key,
    required this.strokeWidth,
    required this.color,
    required this.borderRadius,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        strokeWidth: strokeWidth,
        color: color,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double borderRadius;

  _DashedBorderPainter({
    required this.strokeWidth,
    required this.color,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true
      ..shader = null;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius),
        ),
      );

    final double dashWidth = 6;
    final double dashSpace = 4;
    final intervals = <double>[dashWidth, dashSpace];

    canvas.drawPath(
      dashPath(
        path,
        dashArray: CircularIntervalList<double>(intervals),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_DashedBorderPainter oldDelegate) => false;
}
