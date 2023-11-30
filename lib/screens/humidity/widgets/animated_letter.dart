import 'package:flutter/material.dart';
import 'package:kyla_humidity/core/constants/text_styles.dart';

class AnimatedLetter extends StatefulWidget {
  const AnimatedLetter({super.key, this.letter});

  final String? letter;

  @override
  State<AnimatedLetter> createState() => _AnimatedLetterState();
}

class _AnimatedLetterState extends State<AnimatedLetter> with SingleTickerProviderStateMixin {
  AnimationController? controller;

  String? currentLetter;
  String? prevLetter;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    currentLetter = widget.letter;
    prevLetter = widget.letter;
    super.initState();
  }

  @override
  void didUpdateWidget(AnimatedLetter oldWidget) {
    if (widget.letter != oldWidget.letter) {
      setState(() {
        prevLetter = oldWidget.letter;
        currentLetter = widget.letter;
        controller!
          ..reset()
          ..forward();
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller!,
        builder: (_, __) {
          return SizedBox(
            width: 48,
            child: Stack(
              children: [
                Transform.translate(
                  offset: Offset(0, -controller!.value * 50),
                  child: Opacity(
                    opacity: 1 - controller!.value,
                    child: Text(
                      prevLetter!,
                      style: currentHumidityStyle,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, 50 - controller!.value * 50),
                  child: Opacity(
                    opacity: controller!.value,
                    child: Text(
                      currentLetter!,
                      style: currentHumidityStyle,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
