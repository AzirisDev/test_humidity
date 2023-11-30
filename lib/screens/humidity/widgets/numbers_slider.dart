import 'package:flutter/material.dart';
import 'package:kyla_humidity/core/constants/constants.dart';
import 'package:kyla_humidity/screens/humidity/provider/humidity_data.dart';
import 'package:kyla_humidity/screens/humidity/provider/humidity_provider.dart';
import 'package:kyla_humidity/screens/humidity/widgets/measurements_curved_lines.dart';
import 'package:kyla_humidity/screens/humidity/widgets/measurements_painter.dart';
import 'package:kyla_humidity/screens/humidity/widgets/slider_widget.dart';
import 'package:provider/provider.dart';

class NumbersSlider extends StatefulWidget {
  const NumbersSlider(
    this.oneUnit, {
    super.key,
  });
  final double oneUnit;

  @override
  State<NumbersSlider> createState() => _SliderHandleState();
}

class _SliderHandleState extends State<NumbersSlider> {
  double? dy = 450;
  double diameter = kSliderDiameter;
  HumidityData? humidityData;

  late double _min;
  double? _max;
  late double _stepHeight;
  late void Function(double) updateTrasitionalHumidity;
  late void Function() updateFinalHumidity;

  void handleDrag(details) {
    double? newDy = (details.globalPosition.dy - diameter).clamp(_min, _max);

    if (dy != newDy) {
      setState(() {
        updateTrasitionalHumidity(_calcualteHumidity(newDy));
        dy = newDy;
      });
    }
  }

  late double Function(double?) _calcualteHumidity;

  @override
  void initState() {
    super.initState();
    updateTrasitionalHumidity = context.read<HumidityProvider>().updateTrasitionalValue;
    updateFinalHumidity = context.read<HumidityProvider>().updateFinalValue;

    humidityData = context.read<HumidityData>();
    var fontSizeShift = kNumberFontSize / 2;

    var paddingTop = widget.oneUnit * humidityData!.topPaddingInPercentage + fontSizeShift;
    var paddingBottom = widget.oneUnit * humidityData!.bottomPaddingInPercentage + fontSizeShift;
    var height = widget.oneUnit * 100;
    var body = height - paddingTop - paddingBottom;
    var stepsCount = humidityData!.list.length;
    _stepHeight = body / (stepsCount - 1);
    var disacitvatedTopPart = _stepHeight * (stepsCount - humidityData!.lastIndex - 1);
    var disacitvatedBottomPart = _stepHeight * (humidityData!.firstIndex);

    _calcualteHumidity = (newDy) {
      var percentage = 1 - (newDy! - _min) / (_stepHeight * 5);

      var activeCapacity = humidityData!.list[humidityData!.lastIndex] - humidityData!.list[humidityData!.firstIndex];
      return percentage * activeCapacity + humidityData!.list[humidityData!.firstIndex];
    };

    _min = disacitvatedTopPart + paddingTop;
    _max = height - disacitvatedBottomPart - paddingBottom;
  }

  @override
  Widget build(BuildContext context) {
    var centerY = dy! - diameter / 2;
    return SizedBox(
      width: 100,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 15,
            right: 40,
            child: CustomPaint(painter: MeasurementsPainter(humidityData, centerY)),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 25,
            child: MeasurementsCurevedLine(
              y: centerY,
            ),
          ),
          Positioned(
            right: 0,
            top: centerY,
            child: GestureDetector(
              onVerticalDragStart: handleDrag,
              onVerticalDragUpdate: handleDrag,
              onVerticalDragEnd: (_) => updateFinalHumidity(),
              child: const SliderWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
