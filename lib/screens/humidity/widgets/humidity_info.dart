import 'package:flutter/material.dart';
import 'package:kyla_humidity/core/constants/colors.dart';
import 'package:kyla_humidity/core/constants/text_styles.dart';
import 'package:kyla_humidity/screens/humidity/provider/humidity_provider.dart';
import 'package:kyla_humidity/screens/humidity/widgets/animated_letter.dart';
import 'package:kyla_humidity/screens/humidity/widgets/humidity_subtitle.dart';
import 'package:provider/provider.dart';

class HumidityInfo extends StatelessWidget {
  const HumidityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    var value = context.watch<HumidityProvider>().finalValue;
    return ColoredBox(
      color: AppColors.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(flex: 25),
          const Subtitle('Return temperature'),
          const Spacer(flex: 1),
          Text(
            '20℃',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.mainText),
          ),
          const Spacer(flex: 5),
          const Subtitle('Current humidity'),
          const Spacer(flex: 1),
          Row(
            children: [
              AnimatedLetter(
                letter: value.toString()[0],
              ),
              AnimatedLetter(
                letter: value.toString()[1],
              ),
              SizedBox(
                child: Text('%', style: currentHumidityStyle),
              )
            ],
          ),
          const Spacer(flex: 4),
          const Subtitle('Absolute humidity'),
          const Spacer(flex: 1),
          Text(
            '4gr/fg3',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: AppColors.mainText),
          ),
          const Spacer(flex: 4),
          Icon(
            Icons.warning_amber,
            color: AppColors.primaryYellow,
          ),
          const Spacer(flex: 1),
          RichText(
            text: TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Icon(
                    Icons.brightness_1,
                    size: 8,
                    color: AppColors.primaryYellow,
                  ),
                ),
                const TextSpan(
                  style: TextStyle(height: 1.3),
                  text: ' — extreme humidity level. \n Use precaution for set-points \n outside of 20%-50%',
                ),
              ],
            ),
          ),
          const Spacer(flex: 20),
        ],
      ),
    );
  }
}
