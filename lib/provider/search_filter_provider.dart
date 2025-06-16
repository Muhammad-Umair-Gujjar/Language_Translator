import 'package:flutter/foundation.dart';

class SearchFilterProvider extends ChangeNotifier {
  String _searchText = '';
  String? _fromLanguage = 'All';
  String? _toLanguage = 'All';
  bool _showFavoritesOnly = false;

  String get searchText => _searchText;
  String? get fromLanguage => _fromLanguage;
  String? get toLanguage => _toLanguage;
  bool get showFavoritesOnly => _showFavoritesOnly;

  void setSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  void setFromLanguage(String? lang) {
    _fromLanguage = lang;
    notifyListeners();
  }

  void setToLanguage(String? lang) {
    _toLanguage = lang;
    notifyListeners();
  }

  void clearFilters() {
    _searchText = '';
    _fromLanguage = 'English'; // reset to defaults
    _toLanguage = 'Urdu';
    _showFavoritesOnly = false;
    notifyListeners();
  }
}
