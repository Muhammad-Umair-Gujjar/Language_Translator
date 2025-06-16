import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_translator_app/themes/theme.dart';
import 'package:language_translator_app/widgets/language_dropdown.dart';
import 'package:provider/provider.dart';
import '../data/language.dart';
import '../provider/favourite_provider.dart';
import '../provider/translation_provider.dart';
import '../provider/voice_provider.dart';

class TranslationCard extends StatelessWidget {
  final TextEditingController inputController;
  const TranslationCard({super.key, required this.inputController});

  @override
  Widget build(BuildContext context) {
    final translationProvider = Provider.of<TranslationProvider>(context);
    final voiceProvider = Provider.of<VoiceProvider>(context);
    final favouriteProvider = Provider.of<FavouriteProvider>(context);
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        elevation: 3,
        color: Theme.of(context).cardColor,
        child: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LanguageDropdown(
                selectedLanguage: translationProvider.toLanguage,
                onChanged: (lang) => translationProvider.setToLanguage(lang!),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 100.h,
                    padding:  EdgeInsets.all(6.w),
                    child: SingleChildScrollView(
                      child: Text(
                        translationProvider.translatedText,
                        style: Theme.of(context).textTheme.bodyLarge
                      ),
                    ),
                  ),
                  _buildActionButton(context, translationProvider,
                        favouriteProvider, voiceProvider),

                ],
              ),
            ],
          ),
        ));
  }

  Widget _buildActionButton(
    BuildContext context,
    TranslationProvider translationProvider,
    FavouriteProvider favouriteProvider,
    VoiceProvider voiceProvider,
   )
    {
      return Column(
        children: [
          Consumer2<TranslationProvider, FavouriteProvider>(
            builder: (context, translationProvider, favouriteProvider, _) {
              final inputText = translationProvider.inputText;
              final translatedText = translationProvider.translatedText;
              final fromLang = translationProvider.fromLanguage;
              final toLang = translationProvider.toLanguage;

              final isFav = favouriteProvider.isFavorite(
                inputText,
                translatedText,
                fromLang,
                toLang,
              );

              return IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: AppTheme.favIconColor,
                ),
                tooltip: isFav ? 'Remove from Favorites' : 'Add to Favorites',
                onPressed: () {
                  // final item = TranslationItem(
                  //   inputText: inputText,
                  //   translatedText: translatedText,
                  //   fromLanguage: fromLang,
                  //   toLanguage: toLang,
                  // );
                  // favouriteProvider.toggleFavorite(item);
                  favouriteProvider.toggleFavorite(
                    inputText,
                    translatedText,
                    fromLang,
                    toLang,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFav
                            ? 'Removed from Favorites 💔'
                            : 'Added to Favorites ❤️',
                      ),
                      duration: Duration(seconds: 1),
                      backgroundColor: isFav ? Colors.red : Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.volume_up, color: AppTheme.ttsIconColor),
            tooltip: 'Play Translation',
            onPressed: () {
              final text = translationProvider.translatedText;
              final langName = translationProvider.toLanguage;
              final langCode =
                  languageMap[langName] ?? 'en';// fallback to English// fallback to English
              voiceProvider.speak(context,text, langCode);
            },
          ),
          IconButton(
            icon: Icon(Icons.clear, color: AppTheme.clearIconColor),
            tooltip: 'Clear Text',
            onPressed: () {
              inputController.clear();
              translationProvider.clearText();
            },
          ),
        ],
      );
    }
}
