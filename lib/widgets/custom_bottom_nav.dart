import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:language_translator_app/themes/theme.dart';

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return CurvedNavigationBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      color: AppTheme.primaryColor,
      buttonBackgroundColor: AppTheme.primaryColor,
      animationDuration: Duration(milliseconds: 300),
      height: 50,
      index: selectedIndex,
      onTap: onTap,
      items: const <Widget>[
        Icon(Icons.search, size: 24, color: Colors.white),
        Icon(Icons.home, size: 24, color: Colors.white),
        Icon(Icons.star, size: 24, color: Colors.white),
      ],
    );
  }
}
