import 'package:flutter/material.dart';
import 'package:kyla_humidity/screens/humidity/provider/humidity_provider.dart';
import 'package:kyla_humidity/screens/humidity/widgets/numbers_column.dart';
import 'package:kyla_humidity/screens/humidity/widgets/numbers_slider.dart';
import 'package:provider/provider.dart';

class HumiditySlider extends StatelessWidget {
  const HumiditySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraintes) {
        var maxHeight = constraintes.maxHeight;
        var oneUnit = maxHeight / 100;
        var value = context.watch<HumidityProvider>().transitionalValue;
        return Row(
          children: [NumbersColumn(oneUnit, value), NumbersSlider(oneUnit)],
        );
      },
    );
  }
}
