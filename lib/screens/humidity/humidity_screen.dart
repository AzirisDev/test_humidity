import 'package:flutter/material.dart';
import 'package:kyla_humidity/core/constants/colors.dart';
import 'package:kyla_humidity/screens/humidity/widgets/humidity_info.dart';
import 'package:kyla_humidity/screens/humidity/widgets/humidity_slider.dart';

class HumidityScreen extends StatefulWidget {
  const HumidityScreen({super.key});

  @override
  State<HumidityScreen> createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
  double sliderWidth = 200;
  double infoWidth = 200;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        sliderWidth = MediaQuery.of(context).size.width / 2.2;
        infoWidth = MediaQuery.of(context).size.width - sliderWidth;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: sliderWidth,
            child: Container(
              color: AppColors.background,
              child: const HumiditySlider(),
            ),
          ),
          Expanded(
              child: SizedBox(
            width: infoWidth,
            child: const HumidityInfo(),
          ))
        ],
      ),
    );
  }
}
