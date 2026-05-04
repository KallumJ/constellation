import 'package:flutter/material.dart';

class ConstellationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ConstellationAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Center(
          child: Text(
            "🌌 Constellation",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); 
}