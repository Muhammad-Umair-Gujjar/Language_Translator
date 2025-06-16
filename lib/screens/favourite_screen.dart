import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/favourite_provider.dart';
import '../widgets/translation_list_tile.dart';

class FavoritesScreen extends StatelessWidget {
  final Map<String, String> languageMap; // Pass this to show language names

  const FavoritesScreen({super.key, required this.languageMap});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavouriteProvider>(context).favorites;
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    return Scaffold(
      appBar:
      AppBar(
        title: Text(
          "Favorite Translations",
        ),
      ),
      body: favorites.isEmpty
          ? Center(child: Text('No favorites yet.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final item = favorites[index];

                return TranslationListTile(
                  item: item,
                  onToggleFavorite: () {
                    favouriteProvider.toggleFavorite( item.inputText,
                      item.translatedText,
                      item.fromLanguage,
                      item.toLanguage,); // implement this method in your provider
                  },
                  onRemoveFavorite: () {
                    favouriteProvider.removeFavorite(index);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Removed from Favorites'),
                        duration: const Duration(seconds: 1),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
