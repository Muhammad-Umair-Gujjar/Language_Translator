import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../provider/favourite_provider.dart';
import '../themes/theme.dart';

class TranslationListTile extends StatelessWidget {
  final TranslationItem item;
  final VoidCallback onRemoveFavorite;
  final VoidCallback onToggleFavorite;

  const TranslationListTile({
    super.key,
    required this.item,
    required this.onRemoveFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final FlutterTts flutterTts = FlutterTts();
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      color: theme.cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ListTile(
              leading: const Icon(Icons.translate, color: AppTheme.primaryColor),
              title: Text(item.inputText),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.translatedText),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text("From: ${item.fromLanguage}"),
                      const SizedBox(width: 10),
                      Text("To: ${item.toLanguage}"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.volume_up, color: AppTheme.ttsIconColor),
                tooltip: 'Speak',
                onPressed: () => flutterTts.speak(item.translatedText),
              ),
              const SizedBox(height: 4),
              IconButton(
                icon: const Icon(Icons.copy, color: AppTheme.copyIconColor),
                tooltip: 'Copy',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: item.translatedText));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Copied to clipboard")),
                  );
                },
              ),
              const SizedBox(height: 4),
              IconButton(
                icon: Icon(
                  item.isFavourite ? Icons.favorite : Icons.favorite_border,
                  color: item.isFavourite ? AppTheme.favIconColor : theme.iconTheme.color?.withOpacity(0.5),
                ),
                tooltip: item.isFavourite ? 'Remove from Favorites' : 'Add to Favorites',
                onPressed: onToggleFavorite,
              ),
            ],
          ),
        ],
      ),
    );

    // return Card(
    //   margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Expanded(
    //         child: ListTile(
    //           leading: const Icon(Icons.translate, color: Colors.orange),
    //           title: Text(item.inputText),
    //           subtitle: Column(
    //             children: [
    //               Text(item.translatedText),
    //               const SizedBox(height: 4),
    //               Row(
    //                 children: [
    //                   Text("From: ${item.fromLanguage}"),
    //                   const SizedBox(width: 10),
    //                   Text("To: ${item.toLanguage}"),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Column(
    //         mainAxisAlignment: MainAxisAlignment.end,
    //         children: [
    //           IconButton(
    //             icon: const Icon(Icons.volume_up, color: Colors.blue),
    //             tooltip: 'Speak',
    //             onPressed: () => flutterTts.speak(item.translatedText),
    //           ),
    //           IconButton(
    //             icon: const Icon(Icons.copy, color: Colors.green),
    //             tooltip: 'Copy',
    //             onPressed: () {
    //               Clipboard.setData(ClipboardData(text: item.translatedText));
    //               ScaffoldMessenger.of(context).showSnackBar(
    //                 const SnackBar(content: Text("Copied to clipboard")),
    //               );
    //             },
    //           ),
    //           IconButton(
    //             icon: Icon(
    //               item.isFavourite ? Icons.favorite : Icons.favorite_border,
    //               color: item.isFavourite ? Colors.red : Colors.grey,
    //             ),
    //             tooltip: item.isFavourite ? 'Remove from Favorites' : 'Add to Favorites',
    //             onPressed: onToggleFavorite,
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
