import 'package:flutter/material.dart';
import 'package:kyla_humidity/core/constants/colors.dart';
import 'dart:math' as math;
import 'package:kyla_humidity/core/constants/constants.dart';
import 'package:kyla_humidity/screens/humidity/provider/humidity_data.dart';

class MeasurementsPainter extends CustomPainter {
  MeasurementsPainter(this.config, this.centerY);
  final HumidityData? config;
  final double centerY;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width;
    final height = size.height;
    final linesCount = (config!.list.length - 1) * 5 + 1;

    final paddingTop = config!.topPaddingInPercentage * height / 100 + kNumberFontSize / 2;
    final paddingBottom = config!.bottomPaddingInPercentage * height / 100 + kNumberFontSize / 2;

    final oneLineStep = (height - paddingTop - paddingBottom) / (linesCount - 1);
    var y = paddingTop;
    var path = Path();

    for (var i = 0; i < linesCount; i++) {
      var isLong = i % 5 == 0;
      var startX = isLong ? 22.0 : 29.0;
      var endX = width;
      var fix = 23;
      var distanceTillCenter = (y - centerY - fix).abs();
      if (distanceTillCenter < 50) {
        var sin = distanceTillCenter / 50;
        var angle = math.asin(sin);
        var cos = math.cos(angle);
        var delta = 30 * cos * cos * 1.05;
        startX -= delta;
        endX -= delta;
      }
      path
        ..moveTo(startX, y)
        ..lineTo(endX, y);

      y += oneLineStep;
    }

    var paint = Paint()
      ..color = AppColors.secondaryText
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
