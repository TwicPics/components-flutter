import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(161, 52, 246, 1),
      centerTitle: true,
      elevation: 0,
      leading: const BackButton(color: Colors.white),
      title: Text(title),
      titleTextStyle: const TextStyle(color: Colors.white, fontSize: 22),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
