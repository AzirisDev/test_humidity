import 'package:flutter/material.dart';
import 'package:kyla_humidity/core/common/app_bar.dart';
import 'package:kyla_humidity/core/constants/colors.dart';
import 'package:kyla_humidity/screens/humidity/humidity_screen.dart';

class HumidityScaffold extends StatefulWidget {
  const HumidityScaffold({
    super.key,
  });

  @override
  State<HumidityScaffold> createState() => _HumidityScaffoldState();
}

class _HumidityScaffoldState extends State<HumidityScaffold> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    PlaceholderWidget(
      color: AppColors.background,
      title: "Charts",
    ),
    const HumidityScreen(),
    PlaceholderWidget(
      color: AppColors.background,
      title: "Home",
    ),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: const CustomAppBar(),
      body: _children[_currentIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.mainText,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.insert_chart,
                size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.water_drop,
                size: 30,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;
  final String title;

  const PlaceholderWidget({super.key, required this.color, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 20.0, color: Colors.white),
        ),
      ),
    );
  }
}
