
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/language.dart';
import '../provider/favourite_provider.dart';
import '../provider/search_filter_provider.dart';
import '../widgets/language_dropdown.dart';
import '../widgets/translation_list_tile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<SearchFilterProvider>(context);
    final favoritesProvider = Provider.of<FavouriteProvider>(context);

    final allItems = favoritesProvider.favorites;

    final filteredItems = allItems.where((item) {
      final matchesSearch = item.inputText.toLowerCase().contains(filterProvider.searchText.toLowerCase()) ||
          item.translatedText.toLowerCase().contains(filterProvider.searchText.toLowerCase());

      final matchesFromLang = filterProvider.fromLanguage == null || filterProvider.fromLanguage == 'All' || item.fromLanguage == filterProvider.fromLanguage;
      final matchesToLang = filterProvider.toLanguage == null || filterProvider.toLanguage == 'All' || item.toLanguage == filterProvider.toLanguage;

      final matchesFavorite = !filterProvider.showFavoritesOnly || item.isFavourite;

      return matchesSearch && matchesFromLang && matchesToLang && matchesFavorite;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Translations",
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all,),
            tooltip: 'Clear Filters',
            onPressed: () => filterProvider.clearFilters(),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            _buildSearchField(filterProvider),
            const SizedBox(height: 10),
            _buildFilterRow(context ,filterProvider),
            const SizedBox(height: 5),
            const Divider(),
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(child: Text('No results found.'))
                  : ListView.builder(
                itemCount: filteredItems.length,
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return TranslationListTile(
                    item: item,
                    onToggleFavorite: () {
                      favoritesProvider.toggleFavorite( item.inputText,
                        item.translatedText,
                        item.fromLanguage,
                        item.toLanguage,); // implement this method in your provider
                    },
                    onRemoveFavorite: () {
                      favoritesProvider.removeFromFavorites(item);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Removed from Favorites"),
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField(SearchFilterProvider filterProvider) {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Search' ,
        labelStyle: TextStyle(color: Colors.black54,),
        prefixIcon: const Icon(Icons.search, color: Colors.black54),
      ),
      onChanged: filterProvider.setSearchText,
    );

  }

  Widget _buildFilterRow(BuildContext context,SearchFilterProvider filterProvider) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: LanguageDropdown(
                selectedLanguage: filterProvider.fromLanguage ?? languageMap.keys.first,
                onChanged: filterProvider.setFromLanguage,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: LanguageDropdown(

                selectedLanguage: filterProvider.toLanguage ?? languageMap.keys.first,
                onChanged: filterProvider.setToLanguage,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
