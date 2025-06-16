import 'package:flutter/material.dart';
import 'package:language_translator_app/data/language.dart';

import '../themes/theme.dart';

class LanguageDropdown extends StatelessWidget {
  final String selectedLanguage;
  final ValueChanged<String?> onChanged;
  final Color? backgroundColor;
  final Color? textColor;

  const LanguageDropdown({
    super.key,
    required this.selectedLanguage,
    required this.onChanged,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final languageOptions = ['All', ...languageMap.keys.toList()];
    final bgColor = backgroundColor ?? AppTheme.primaryColor;
    final fgColor = textColor ?? Colors.white;
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedLanguage,
          iconEnabledColor: fgColor,
          dropdownColor: bgColor,
          underline: const SizedBox(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: fgColor),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          items: languageOptions.map((lang) {
            return DropdownMenuItem<String>(
              value: lang,
              child: Text(lang, style: TextStyle(color: fgColor)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
