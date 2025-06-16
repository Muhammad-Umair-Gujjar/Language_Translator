import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TranslationItem {
  final String inputText;
  final String translatedText;
  final String fromLanguage;
  final String toLanguage;
  bool isFavourite;

  TranslationItem({
    required this.inputText,
    required this.translatedText,
    required this.fromLanguage,
    required this.toLanguage,
    this.isFavourite=true,
  });

  Map<String, dynamic> toMap() {
    return {
      'inputText': inputText,
      'translatedText': translatedText,
      'fromLanguage': fromLanguage,
      'toLanguage': toLanguage,
      'isFavourite': isFavourite,
    };
  }

  factory TranslationItem.fromMap(Map<String, dynamic> map) {
    return TranslationItem(
      inputText: map['inputText'],
      translatedText: map['translatedText'],
      fromLanguage: map['fromLanguage'],
      toLanguage: map['toLanguage'],
      isFavourite: map['isFavourite'] ?? true,
    );
  }

}

class FavouriteProvider with ChangeNotifier {
  final List<TranslationItem> _favorites = [];

  List<TranslationItem> get favorites => _favorites;

  void addToFavorites(
      String inputText, String translatedText, String fromLang, String toLang) {
    if (inputText.trim().isNotEmpty && translatedText.trim().isNotEmpty) {
      _favorites.add(
        TranslationItem(
          inputText: inputText,
          translatedText: translatedText,
          fromLanguage: fromLang,
          toLanguage: toLang,
        ),
      );
      saveFavoritesToPrefs();
      notifyListeners();
    }
  }


  Future<void> saveFavoritesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert each TranslationItem to a Map and then to a JSON string
    List<String> favoritesJson = _favorites.map((item) {
      return json.encode({
        'inputText': item.inputText,
        'translatedText': item.translatedText,
        'fromLanguage': item.fromLanguage,
        'toLanguage': item.toLanguage,
        'isFavourite': item.isFavourite,
      });
    }).toList();

    await prefs.setStringList('favorites', favoritesJson);
  }

  Future<void> loadFavoritesFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? favoritesJson = prefs.getStringList('favorites');

    if (favoritesJson != null) {
      _favorites.clear();
      _favorites.addAll(favoritesJson.map((jsonStr) {
        final data = json.decode(jsonStr);
        return TranslationItem(
          inputText: data['inputText'],
          translatedText: data['translatedText'],
          fromLanguage: data['fromLanguage'],
          toLanguage: data['toLanguage'],
          isFavourite: data['isFavourite'] ?? true,
        );
      }).toList());

      notifyListeners();
    }
  }


  bool isFavorite(String inputText, String translatedText, String fromLang, String toLang) {
    return _favorites.any((item) =>
    item.inputText == inputText &&
        item.translatedText == translatedText &&
        item.fromLanguage == fromLang &&
        item.toLanguage == toLang);
  }

  void toggleFavorite(String inputText, String translatedText, String fromLang, String toLang) {
    final existingIndex = _favorites.indexWhere((item) =>
    item.inputText == inputText &&
        item.translatedText == translatedText &&
        item.fromLanguage == fromLang &&
        item.toLanguage == toLang);

    if (existingIndex != -1) {
      _favorites.removeAt(existingIndex);
    } else {
      _favorites.add(
        TranslationItem(
          inputText: inputText,
          translatedText: translatedText,
          fromLanguage: fromLang,
          toLanguage: toLang,
        ),
      );
    }
    saveFavoritesToPrefs();
    notifyListeners();
  }


  // void toggleFavorite(TranslationItem item) {
  //   item.isFavourite = !item.isFavourite;
  //   if (item.isFavourite) {
  //     _favorites.add(item);
  //   } else {
  //     _favorites.removeWhere((element) =>
  //     element.inputText == item.inputText &&
  //         element.translatedText == item.translatedText &&
  //         element.fromLanguage == item.fromLanguage &&
  //         element.toLanguage == item.toLanguage);
  //   }
  //   saveFavoritesToPrefs();
  //   notifyListeners();
  // }

  void removeFromFavorites(TranslationItem item) {
    _favorites.remove(item);
    saveFavoritesToPrefs();
    notifyListeners();
  }


  void removeFavorite(int index) {
    _favorites.removeAt(index);
    saveFavoritesToPrefs();
    notifyListeners();
  }

  void clearFavorites() {
    _favorites.clear();
    saveFavoritesToPrefs();
    notifyListeners();
  }
}
