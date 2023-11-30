import 'package:flutter/material.dart';
import 'package:kyla_humidity/core/constants/colors.dart';
import 'package:kyla_humidity/core/constants/constants.dart';
import 'package:kyla_humidity/screens/humidity/provider/humidity_data.dart';
import 'package:kyla_humidity/screens/humidity/provider/humidity_provider.dart';
import 'package:provider/provider.dart';

class NumbersColumn extends StatefulWidget {
  const NumbersColumn(
    this.oneUnit,
    this.value, {
    super.key,
  });

  final double oneUnit;
  final double? value;

  @override
  State<NumbersColumn> createState() => _MeasurementNumbersState();
}

class _MeasurementNumbersState extends State<NumbersColumn> {
  int? activeIndex;

  late HumidityData humidityData;
  @override
  void initState() {
    super.initState();

    humidityData = context.read<HumidityData>();
    var initValue = widget.value;

    activeIndex = findNearestIndex(initValue);
  }

  int findNearestIndex(double? value) {
    var a = [...humidityData.list.reversed]..sort((a, b) => (a - value!).abs().compareTo((b - value).abs()));
    return humidityData.list.length - humidityData.list.indexOf(a.first) - 1;
  }

  @override
  void didUpdateWidget(NumbersColumn oldWidget) {
    var oldActiveValue = humidityData.list.reversed.toList()[activeIndex!];

    var delta = (widget.value! - oldActiveValue).abs().round();

    if (delta >= 5) {
      activeIndex = findNearestIndex(widget.value);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var value = context.watch<HumidityProvider>().transitionalValue!;
    var list = humidityData.list;
    var firstIndex = humidityData.firstIndex;
    var lastIndex = humidityData.lastIndex;
    var paddingTop = humidityData.topPaddingInPercentage * widget.oneUnit;
    var paddingBottom = humidityData.bottomPaddingInPercentage * widget.oneUnit;

    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: paddingTop,
            child: Text(value.toStringAsFixed(3)),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildNumbers(list, firstIndex, lastIndex),
            ),
          ),
          SizedBox(height: paddingBottom),
        ],
      ),
    );
  }

  List<Widget> _buildNumbers(List list, int firstIndex, int lastIndex) {
    return list.reversed
        .toList()
        .asMap()
        .map((i, n) => MapEntry(
              i,
              Row(
                children: [
                  Icon(
                    Icons.brightness_1,
                    size: 6,
                    color: n <= list[firstIndex] || n >= list[lastIndex] ? AppColors.primaryYellow : Colors.transparent,
                  ),
                  AnimatedText(
                    key: ValueKey(n),
                    notActiveNumber: n,
                    activeValue: widget.value,
                    isActive: i == activeIndex,
                    oneUnit: widget.oneUnit,
                  ),
                ],
              ),
            ))
        .values
        .toList();
  }
}

class AnimatedText extends StatefulWidget {
  const AnimatedText({
    super.key,
    this.notActiveNumber,
    this.activeValue,
    this.isActive,
    this.oneUnit,
  });

  final int? notActiveNumber;
  final double? activeValue;
  final double? oneUnit;
  final bool? isActive;

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late Tween<Color?> colorTween;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    colorTween = ColorTween(
      begin: AppColors.mainText,
      end: AppColors.active,
    );
    if (widget.isActive!) {
      controller!.forward();
    }
    super.initState();
  }

  late bool isGoingUp;

  @override
  void didUpdateWidget(AnimatedText oldWidget) {
    if (widget.isActive! && !oldWidget.isActive!) {
      controller!.forward();
    } else if (!widget.isActive! && oldWidget.isActive!) {
      isGoingUp = widget.activeValue! > widget.notActiveNumber!;
      controller!.reverse();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller!,
        builder: (_, __) {
          String text;
          Offset offset;

          if (controller!.isAnimating && controller!.status == AnimationStatus.reverse) {
            var number = widget.notActiveNumber! + (controller!.value.round() * 5 * (isGoingUp ? -1 : 1));
            text = ' $number%';
            var dy = controller!.value * 5 * (isGoingUp ? -1 : 1) * widget.oneUnit!;
            offset = Offset(0, dy);
          } else {
            if (widget.isActive!) {
              text = ' ${widget.activeValue!.round()}%';
              var dy = (widget.notActiveNumber! - widget.activeValue!) * widget.oneUnit!;
              offset = Offset(0, dy);
            } else {
              text = ' ${widget.notActiveNumber}%';
              offset = Offset.zero;
            }
          }

          return Transform.scale(
            alignment: Alignment.centerLeft,
            scale: 1 + (0.1 * controller!.value),
            child: Transform.translate(
              offset: offset,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: kNumberFontSize,
                  fontWeight: FontWeight.w900,
                  height: 1,
                  color: colorTween.evaluate(controller!),
                ),
              ),
            ),
          );
        });
  }
}
