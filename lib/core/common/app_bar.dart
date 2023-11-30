import 'package:flutter/material.dart';
import 'package:kyla_humidity/core/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(backgroundColor: AppColors.background, elevation: 0.0, actions: [
      IconButton(
        icon: const Icon(
          Icons.more_horiz,
          size: 30,
        ),
        onPressed: () {
          // Handle menu icon pressed
        },
      ),
    ]);
  }
}
