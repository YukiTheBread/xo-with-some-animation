import 'package:flutter/material.dart';
import 'dart:math';
import '../models/mark.dart';

/// วาดกระดาน NxN และเครื่องหมาย 'O' / 'X'
class BoardPainter extends CustomPainter {
  final List<Mark> marks;
  final double markSize;
  final int gridSize;

  BoardPainter({
    required this.marks,
    required this.markSize,
    required this.gridSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint gridPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    final double cellWidth = size.width / gridSize;
    final double cellHeight = size.height / gridSize;

    // วาดเส้นตั้ง
    for (int i = 1; i < gridSize; i++) {
      final double x = cellWidth * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    // วาดเส้นนอน
    for (int i = 1; i < gridSize; i++) {
      final double y = cellHeight * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final Paint oPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    final Paint xPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;

    for (final Mark mark in marks) {
      if (mark.type == 'O') {
        // วาดแบบ Arc ตาม progress
        final rect =
            Rect.fromCircle(center: mark.position, radius: markSize / 2);
        const double fullCircle = pi * 2;
        final double sweep = fullCircle * mark.progress;
        canvas.drawArc(rect, 0, sweep, false, oPaint);
      } else if (mark.type == 'X') {
        final double halfSize = markSize / 2;
        final double xprogress = mark.progress;

        // เส้นแรก ( \ )
        if (xprogress > 0.0) {
          double prog1 = (xprogress <= 0.5) ? (xprogress * 2) : 1.0;
          canvas.drawLine(
            mark.position + Offset(-halfSize, -halfSize),
            mark.position +
                Offset(-halfSize + (markSize * prog1),
                    -halfSize + (markSize * prog1)),
            xPaint,
          );
        }

        // เส้นที่สอง ( / )
        if (xprogress > 0.5) {
          double prog2 = (xprogress - 0.5) * 2;
          canvas.drawLine(
            mark.position + Offset(-halfSize, halfSize),
            mark.position +
                Offset(-halfSize + (markSize * prog2),
                    halfSize - (markSize * prog2)),
            xPaint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant BoardPainter oldDelegate) {
    return oldDelegate.marks != marks ||
        oldDelegate.markSize != markSize ||
        oldDelegate.gridSize != gridSize;
  }
}
