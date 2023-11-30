import 'package:flutter/material.dart';
import 'package:kyla_humidity/core/constants/colors.dart';
import 'package:kyla_humidity/core/constants/constants.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.mainText,
      ),
      height: kSliderDiameter,
      width: kSliderDiameter,
      alignment: Alignment.center,
      child: Icon(
        Icons.arrow_back,
        color: AppColors.secondaryText,
        size: 20,
      ),
    );
  }
}
