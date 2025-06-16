
// import 'package:flutter/material.dart';
//
// class AppTheme {
//   // Define color constants
//   static const Color primaryColor = Colors.orange;
//   static const Color backgroundColor = Color(0xFFF5F5F5);
//   static const Color cardColor = Colors.white;
//   static const Color micIconColor = Colors.blue;
//   static const Color favoriteIconColor = Colors.red;
//   static const Color ttsIconColor = Colors.green;
//   static const Color copyIconColor = Colors.green;
//   static const Color clearIconColor = Colors.grey;
//   static const Color navBarBackgroundColor = Colors.white;
//
//   // App theme
//   static final ThemeData lightTheme = ThemeData(
//     primaryColor: primaryColor,
//     scaffoldBackgroundColor: backgroundColor,
//     cardColor: cardColor,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: primaryColor,
//       centerTitle: true,
//       titleTextStyle: TextStyle(
//         color: Colors.white,
//         fontSize: 20,
//         fontWeight: FontWeight.bold,
//       ),
//       iconTheme: IconThemeData(color: Colors.white),
//       elevation: 2,
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: primaryColor,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: const Color(0xFFF0F0F0),
//       hintStyle: const TextStyle(color: Colors.black54),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide.none,
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: const BorderSide(color: primaryColor, width: 2),
//       ),
//     ),
//     textTheme: const TextTheme(
//       bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
//       bodyMedium: TextStyle(color: Colors.black87),
//     ),
//     iconTheme: const IconThemeData(color: Colors.black87),
//     snackBarTheme: SnackBarThemeData(
//       backgroundColor: Colors.grey[800],
//       contentTextStyle: const TextStyle(color: Colors.white),
//       behavior: SnackBarBehavior.floating,
//     ),
//     dropdownMenuTheme: DropdownMenuThemeData(
//       inputDecorationTheme: const InputDecorationTheme(
//         border: InputBorder.none,
//       ),
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  // Define color constants
  static const Color primaryColor = Colors.orange;
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Colors.white;
  static const Color micIconColor = Colors.blue;
  static const Color favIconColor = Colors.red;
  static const Color ttsIconColor = Colors.blue;
  static const Color copyIconColor = Colors.green;
  static const Color clearIconColor = Colors.grey;
  static const Color navBarBackgroundColor = Colors.white;

  // App theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    cardColor: cardColor,

    // AppBar
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      centerTitle: true,
      elevation: 2,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    // Elevated buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle:  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.w),
      ),
    ),

    // Input fields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor:  Colors.white,
      hintStyle: const TextStyle(color: Colors.black54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColor,
      ),
    ),
    ),

    // Text
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black87),
    ),

    // Icons
    iconTheme: const IconThemeData(color: Colors.black87),

    // SnackBars
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.grey[800],
      contentTextStyle: const TextStyle(color: Colors.white),
      behavior: SnackBarBehavior.floating,
    ),

    // Dropdown menus
    dropdownMenuTheme: DropdownMenuThemeData(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
    ),

    // BottomNavigationBar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: navBarBackgroundColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.black54,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
  );
}
