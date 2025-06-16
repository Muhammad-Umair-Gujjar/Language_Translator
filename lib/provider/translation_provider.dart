import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import '../data/language.dart';

class TranslationProvider with ChangeNotifier {
  final GoogleTranslator _translator = GoogleTranslator();
  String _fromLanguage = 'English';
  String _toLanguage = 'Urdu';
  String _inputText = '';
  String _translatedText = "Result here...";
  final List<Map<String, String>> _favorites = [];

  String get fromLanguage => _fromLanguage;

  String get toLanguage => _toLanguage;

  String get inputText => _inputText;

  String get translatedText => _translatedText;

  List<Map<String, String>> get favorites => _favorites;

  void setFromLanguage(String lang) {
    _fromLanguage = lang;
    notifyListeners();
  }

  void setToLanguage(String lang) {
    _toLanguage = lang;
    notifyListeners();
  }

  void setInputText(String text) {
    _inputText = text;
    notifyListeners();
  }

  void clearText() {
    _inputText = '';
    _translatedText = '';
    notifyListeners();
  }

  Future<void> autoDetectLanguage(String text) async {
    try {
      final translation = await _translator.translate(text, to: 'en');
      String detectedCode = translation.sourceLanguage.code;

      String? detectedLanguage = languageMap.entries
          .firstWhere(
              (entry) => entry.value == detectedCode,
          orElse: () => const MapEntry('Unknown', ''))
          .key;

      if (detectedLanguage != 'Unknown') {
        _fromLanguage = detectedLanguage;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Language detection failed: $e');
    }
  }

  Future<void> translateText() async {
    if (_inputText.isEmpty) return;
    try {
      final translation = await _translator.translate(
        _inputText,
        from: languageMap[_fromLanguage]!,
        to: languageMap[_toLanguage]!,
      );
      _translatedText = translation.text;
      notifyListeners();
    } catch (e) {
      _translatedText = 'Translation failed.';
      notifyListeners();
    }

  }

  // Future<void> translateText() async {
  //   if (_inputText.isEmpty) return;
  //
  //   try {
  //     String fromLangCode = languageMap[_fromLanguage]!;
  //     if (_fromLanguage == "Auto") {
  //       final translation = await _translator.translate(_inputText, to: languageMap[_toLanguage]!);
  //       _translatedText = translation.text;
  //       _fromLanguage = languageMap.entries.firstWhere(
  //             (entry) => entry.value == translation.sourceLanguage.code,
  //         orElse: () => const MapEntry('Unknown', ''),
  //       ).key;
  //     } else {
  //       final translation = await _translator.translate(
  //         _inputText,
  //         from: fromLangCode,
  //         to: languageMap[_toLanguage]!,
  //       );
  //       _translatedText = translation.text;
  //     }
  //   } catch (e) {
  //     _translatedText = 'Translation failed.';
  //   }
  //
  //   notifyListeners();
  // }

}
