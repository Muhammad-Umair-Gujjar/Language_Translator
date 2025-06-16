import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:language_translator_app/themes/theme.dart';
import 'package:language_translator_app/widgets/language_dropdown.dart';
import 'package:provider/provider.dart';
import '../provider/translation_provider.dart';
import '../provider/voice_provider.dart';

class InputCard extends StatelessWidget {
  final TextEditingController controller;
  const InputCard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final translationProvider = Provider.of<TranslationProvider>(context);
    final voiceProvider = Provider.of<VoiceProvider>(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      elevation: 3,
      color: Theme.of(context).cardColor,
      child: Padding(
          padding: EdgeInsets.all(10.0.w),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            LanguageDropdown(
              selectedLanguage: translationProvider.fromLanguage,
              onChanged: (lang) => translationProvider.setFromLanguage(lang!),
            ),
            Row(
              children: [
                Expanded(
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      inputDecorationTheme: const InputDecorationTheme(
                        filled: false, // override filled and fillColor
                        fillColor: Colors.transparent,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,// retain your custom no-border look
                      ),
                    ),
                    child: TextFormField(
                      controller: controller,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration: InputDecoration(
                        hintText: 'Speak or enter text to translate',
                        hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                        onChanged: (value) {
                        translationProvider.setInputText(value);
                        translationProvider.autoDetectLanguage(value);
                      },
                    ),
                  
                  ),
                ),
                IconButton(
                  icon: Icon(
                    voiceProvider.isListening ? Icons.mic : Icons.mic_none,
                    color: AppTheme.micIconColor,
                  ),
                  tooltip: 'Speak',
                  onPressed: () {
                    if (voiceProvider.isListening) {
                      voiceProvider.stopListening();
                    } else {
                      voiceProvider.startListening(context,(spokenText) {
                        controller.text = spokenText;
                        translationProvider.setInputText(spokenText);
                        translationProvider
                            .autoDetectLanguage(spokenText); // <-- Detect here
                      });
                    }
                  },
                ),
              ],
            ),
          ])),
    );
  }
}
