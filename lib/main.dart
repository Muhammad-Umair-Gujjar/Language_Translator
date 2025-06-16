
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_translator_app/provider/bottom_nav_provider.dart';
import 'package:language_translator_app/provider/favourite_provider.dart';
import 'package:language_translator_app/provider/search_filter_provider.dart';
import 'package:language_translator_app/provider/voice_provider.dart';
import 'package:language_translator_app/themes/theme.dart';
import 'package:provider/provider.dart';
import 'package:language_translator_app/provider/translation_provider.dart';
import 'package:language_translator_app/screens/home_screen.dart';

void main() {
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TranslationProvider()),
          ChangeNotifierProvider(create: (_) => FavouriteProvider()),
          ChangeNotifierProvider(create: (_) => VoiceProvider()),
          ChangeNotifierProvider(create: (_) => SearchFilterProvider()),
          ChangeNotifierProvider(create: (_) => BottomNavProvider()),
        ],
        child:  MyApp(),
        ),

      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(411, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Language Translator',
        theme: AppTheme.lightTheme,
        home: child,
      ),
      child: const HomeScreen(),
    );
  }
}
