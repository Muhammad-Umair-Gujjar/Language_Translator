
import 'package:flutter/material.dart';
import 'package:language_translator_app/data/language.dart';
import 'package:language_translator_app/provider/bottom_nav_provider.dart';
import 'package:language_translator_app/screens/search_screen.dart';
import 'package:provider/provider.dart';
import '../provider/favourite_provider.dart';
import '../widgets/custom_bottom_nav.dart';
import 'favourite_screen.dart';
import 'home_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    SearchScreen(),
    HomeContent(),
    FavoritesScreen(languageMap: languageMap),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomNavProvider = Provider.of<BottomNavProvider>(context);
    final favouriteProvider = Provider.of<FavouriteProvider>(context, listen: false);

    // Load favorites only once
    WidgetsBinding.instance.addPostFrameCallback((_) {
      favouriteProvider.loadFavoritesFromPrefs();
    });
    return Scaffold(
      body:
      AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: _pages[bottomNavProvider.selectedIndex],
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        }
      ),

      bottomNavigationBar: CustomBottomNav(
        selectedIndex: bottomNavProvider.selectedIndex,
        onTap: (index)=>bottomNavProvider.setIndex(index),
      ),
    );
    }
}



