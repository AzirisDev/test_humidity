import 'package:flutter/material.dart';
import 'package:kyla_humidity/core/constants/text_styles.dart';

class Subtitle extends StatelessWidget {
  const Subtitle(
    this.text, {
    Key? key,
  }) : super(key: key);

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: subtitleStyle,
    );
  }
}
